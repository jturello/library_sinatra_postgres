class Patron

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.getvalue(0,0).to_i
  end

  define_singleton_method(:delete_all) do
    DB.exec("DELETE FROM patrons;")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
  end

  def self.all
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    returned_patrons.each do |patron|
      patrons.push(Patron.new({:id => patron['id'], :name => patron['name']}))
    end
    patrons
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patrons WHERE id = #{id}").first()
    return Patron.new({id: patron['id'].to_i, name: patron['name']})
  end

  def ==(other)
    (@id == other.id) && (@name == other.name)
  end

  def update_name!(new_name)
    @name = new_name
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id}")
  end
end
