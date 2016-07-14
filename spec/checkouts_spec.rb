require('spec_helper')

describe('Checkout') do

  describe('#initialize') do

    it('instantiates a checkout object') do
      patron = Patron.new({:id => nil, :name => "Conway Twitty"})
      expect(Checkout.new({:patron => patron}).class).to eq(Checkout)
    end

    it('instantiates a checkout object with a Patron instance variable') do
      patron = Patron.new({:id => nil, :name => "Conway Twitty"})
      checkout = Checkout.new({:patron => patron})
      expect(checkout.patron).to eq(patron)
    end

    it('instantiates a checkout object with a Book instance variable') do
      patron = Patron.new({:id => nil, :name => "Conway Twitty"})
      book = Book.new({:id => nil, :title => "Hawaii"})
      checkout = Checkout.new({:patron => patron, :book => book})
      expect(checkout.book).to eq(book)
    end

    it('instantiates a checkout object with a due_date instance variable') do
      patron = Patron.new({:id => nil, :name => "Conway Twitty"})
      book = Book.new({:id => nil, :title => "20,000 Leagues Under the Sea"})
      current = Time.new()
      due_date =  "#{current.year}-#{current.day}-#{current.month}"
      checkout = Checkout.new({:patron => patron, :book => book, :due_date => due_date})
      expect(checkout.due_date).to eq(due_date)
    end


  end


end
