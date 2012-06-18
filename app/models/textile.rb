require 'RedCloth'

class Textile < RedCloth::TextileDoc
  include Mongoid::Fields::Serializable
  def serialize(object) 
    object.to_s
  end
  def deserialize(object)
    object = '' unless object 
    RedCloth.new(object)
  end 
  # def initialize(string = '')
  #   super
  # end
end