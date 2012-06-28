require 'RedCloth'

class Textile < RedCloth::TextileDoc
  include Mongoid::Fields::Serializable

  attr_accessor :max
  
  def serialize(object) 
    object.to_s
  end
  def deserialize(object)
    object = '' unless object 
    RedCloth.new(object)
  end 
 
end