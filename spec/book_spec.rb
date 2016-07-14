require('spec_helper')

describe(Book) do

  before(:each) do
    DB.exec("DELETE FROM authors_books;")
    Book.delete_all()
  end

  describe('#initialize') do
    it('instantiates a book object') do
      book = Book.new({:title => 'Cat in the Hat'})
      expect(book.class).to eq(Book)
    end

    it('instantiates a book with a title') do
      book = Book.new({:title => 'Cat in the Hat'})
      expect(book.title).to eq('Cat in the Hat')
    end

    it('instantiates a book with an id') do
      book = Book.new({:id => 1, :title => 'Red'})
      expect(book.id).not_to eq(nil)
    end
  end

  describe('#save') do
    it('creates/stores book objects on the database') do
      book = Book.new({:id => nil, :title => 'Red'})
      book.save()
      result = DB.exec("SELECT title FROM books WHERE title = 'Red';")
      expect(result.getvalue(0,0)).to eq('Red')
    end
  end

  describe('.delete_all') do
    it('deletes stored book objects on the database') do
      book = Book.new({:id => nil, :title => 'Blue'})
      book.save()
      Book.delete_all
      result = DB.exec("SELECT * FROM books;")
      expect(result.values.size()).to eq(0)
    end
  end

  describe('#delete') do
    it('deletes a book from the database') do
      book = Book.new({:id => nil, :title => 'Green'})
      book.save()
      book.delete
      result = DB.exec("SELECT id FROM books WHERE id = #{book.id};")
      expect(result.values.size()).to eq(0)
    end
  end

  describe('.all') do
    it('returns all books') do
      book1 = Book.new({:id => nil, :title => 'Red'})
      book2 = Book.new({:id => nil, :title => 'Green'})
      book3 = Book.new({:id => nil, :title => 'Yellow'})
      book1.save()
      book2.save()
      book3.save()
      expect(Book.all().size).to eq(3)
    end
  end

  describe('.find') do
    it('returns the book with the input id') do
      book1 = Book.new({:id => nil, :title => 'Red'})
      book2 = Book.new({:id => nil, :title => 'Green'})
      book1.save()
      book2.save()
      expect(Book.find(book2.id)).to eq(book2)
    end
  end

  describe('#==') do
    it('returns true if the objects @id and @title are equal') do
      book1 = Book.new({:id => nil, :title => 'Red'})
      book1.save()
      book2 = Book.find(book1.id)
      expect(book1).to eq(Book.find(book2.id))
    end

    it('returns false if the objects @id and @title are not equal') do
      book1 = Book.new({:id => nil, :title => 'Red'})
      book1.save()
      book2 = Book.find(book1.id)
      book3 = Book.new({:id => nil, :title => 'Red'})
      book3.save
      expect(book1).not_to eq(Book.find(book3.id))
    end
  end

  describe('#update_title') do
    it('will change the title of the book') do
      book1 = Book.new({:id => nil, :title => 'Red'})
      book1.save()
      book1.update_title!('Green')
      book2 = Book.find(book1.id)
      expect(book2.title).to eq('Green')
    end
  end

  describe('#add_authors') do
    it("let's user associate authors with books") do
      book = Book.new({:id => nil, :title => "The Hobbit"})
      book.save()
      tolkien = Author.new({:id => nil, :name => 'J.R.R Tolkien'})
      creighton = Author.new({:id => nil, :name => 'Michael Creighton'})
      tolkien.save()
      creighton.save()
      book.add_authors({:author_ids => [tolkien.id(), creighton.id()]})
      expect(book.authors()).to eq([tolkien, creighton])
    end
  end
end
