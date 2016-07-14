require('rspec')
require('books')
require('authors')
require('patrons')
require('checkouts')
require('pg')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|

  config.after(:each) do
    DB.exec("DELETE FROM authors_books;")
    DB.exec("DELETE FROM books;")
    DB.exec("DELETE FROM authors;")
  end
end
