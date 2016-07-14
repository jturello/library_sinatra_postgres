require('spec_helper')

describe(Patron) do

  before(:each) do
    Patron.delete_all()
  end

  describe('#initialize') do
    it('instantiates an patron object') do
      patron = Patron.new({:name => 'Mark Twain'})
      expect(patron.class).to eq(Patron)
    end

    it('instantiates a patron with a name') do
      patron = Patron.new({:name => 'Mark Twain'})
      expect(patron.name).to eq('Mark Twain')
    end

    it('instantiates a patron with an id') do
      patron = Patron.new({:id => 1, :name => 'Michael Creighton'})
      expect(patron.id).not_to eq(nil)
    end
  end

  describe('#save') do
    it('creates/stores patron objects on the database') do
      patron = Patron.new({:id => nil, :name => 'Dr. Seuss'})
      patron.save()
      result = DB.exec("SELECT name FROM patrons WHERE name = 'Dr. Seuss';")
      expect(result.getvalue(0,0)).to eq('Dr. Seuss')
    end
  end

  describe('.delete_all') do
    it('deletes stored patron objects on the database') do
      patron1 = Patron.new({:id => nil, :name => 'Italo Calvino'})
      patron1.save()
      patron2 = Patron.new({:id => nil, :name => 'Tom Clancy'})
      patron2.save()
      Patron.delete_all
      result = DB.exec("SELECT * FROM patrons;")
      expect(result.values.size()).to eq(0)
    end
  end

  describe('#delete') do
    it('deletes a patron from the database') do
      patron = Patron.new({:id => nil, :name => 'Tom Clancy'})
      patron.save()
      patron.delete
      result = DB.exec("SELECT id FROM patrons WHERE id = #{patron.id};")
      expect(result.values.size()).to eq(0)
    end
  end

  describe('.all') do
    
    it('returns all patrons') do
      patron1 = Patron.new({:id => nil, :name => 'Tom'})
      patron2 = Patron.new({:id => nil, :name => 'Dick'})
      patron3 = Patron.new({:id => nil, :name => 'Harry'})
      patron1.save()
      patron2.save()
      patron3.save()
      expect(Patron.all().size).to eq(3)
    end
  end

  describe('.find') do

    it('returns the patron with the input id') do
      patron1 = Patron.new({:id => nil, :name => 'Red'})
      patron2 = Patron.new({:id => nil, :name => 'Green'})
      patron1.save()
      patron2.save()
      expect(Patron.find(patron2.id)).to eq(patron2)
    end
  end

  describe('#==') do

    it('returns true if the patron objects @id and @title are equal') do
      patron1 = Patron.new({:id => nil, :name => 'Red'})
      patron1.save()
      patron2 = Patron.find(patron1.id)
      expect(patron1).to eq(Patron.find(patron2.id))
    end

    it('returns false if the objects @id and @name are not equal') do
      patron1 = Patron.new({:id => nil, :name => 'Red'})
      patron1.save()
      patron2 = Patron.find(patron1.id)
      patron3 = Patron.new({:id => nil, :name => 'Red'})
      patron3.save
      expect(patron1).not_to eq(Patron.find(patron3.id))
    end
  end

  describe('#update_name') do
    it('will change the name of the patron') do
      patron1 = Patron.new({:id => nil, :name => 'Red'})
      patron1.save()
      patron1.update_name!('Green')
      patron2 = Patron.find(patron1.id)
      expect(patron2.name).to eq('Green')
    end
  end
end
