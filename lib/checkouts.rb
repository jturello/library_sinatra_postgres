class Checkout

  attr_reader :book, :patron, :due_date

  def initialize(args)
    @patron = args[:patron]
    @book = args[:book]
    @due_date = args[:due_date]

  end

end
