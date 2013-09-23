require 'json'
require 'net/http'
require 'uri'
class Location
  include DataMapper::Resource

  attr_accessor :address

  property :id, Serial
  property :name, Text
  property :shorthand, Text
  property :x, Decimal
  property :y, Decimal

  #has n, :tasks, :through => Resource, :required => false

  def self.distance(location_1, location_2)

  end

  def pretty_print
    puts "#{id}: #{name}. Location: #{x.to_f}, #{y.to_f}"
  end

  before :save do
    if(address)
      uri = URI(URI.escape("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false"))
      response = Net::HTTP.get_response(uri)
      json = response.body
      hash = JSON.parse(json)
      self.x = hash["results"][0]["geometry"]["location"]["lat"]
      self.y = hash["results"][0]["geometry"]["location"]["lng"]
    end
  end
end