class Book

  attr_reader :title, :id

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @title = attributes[:title]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.getvalue(0,0).to_i
  end

  define_singleton_method(:delete_all) do
    DB.exec("DELETE FROM authors_books;")
    DB.exec("DELETE FROM books;")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors_books WHERE book_id = #{@id};")
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      books.push(Book.new({:id => book['id'], :title => book['title']}))
    end
    books
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id}").first()
    return Book.new({id: book['id'].to_i, title: book['title']})
  end

  def ==(other)
    (@id == other.id) && (@title == other.title)
  end

  def update_title!(new_title)
    @title = new_title
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id}")
  end

  def add_authors(args)
     args.fetch(:author_ids, []).each() do |author_id|
       DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{@id});")
     end
   end

   def authors()
     authors = []
     results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{@id};")
     results.each() do |result|
       author_id = result.fetch("author_id").to_i
       author = DB.exec("SELECT name FROM authors WHERE id = #{author_id};")
       name = author.first().fetch("name")
       authors.push(Author.new({:id => author_id, :name => name}))
     end
     authors
   end

end
