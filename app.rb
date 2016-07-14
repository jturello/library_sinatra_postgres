require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/books')
require('./lib/authors')
require('./lib/patrons')
require('pry')
require('launchy')
require('pg')

# DB = PG.connect({:dbname => 'library_test'})


get('/') do
  @page_title = "Library App"
  erb(:index)
end

get('/admin') do
    @page_title = "Book Catalog"
    erb(:books)
end

post('/add_book') do
  title = params[:book]
  book = Book.new({:id => nil, :title => title})
  book.save()
  erb(:books)
end

get ('/books/:id') do
  @page_title = "Book Detail Page"
  @book = Book.find(params[:id].to_i)
  # binding.pry

  erb(:book)
end
