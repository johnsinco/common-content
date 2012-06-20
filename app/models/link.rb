class Link < String
  include Mongoid::Fields::Serializable

  def serialize(object) 
    object.to_s
  end
  def deserialize(object)
    Link.new(object || '')
  end 
end