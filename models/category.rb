class Category
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :lazy => false

  has n, :tasks

  def pretty_print
    puts "#{self.id}: #{self.name}"
  end

end