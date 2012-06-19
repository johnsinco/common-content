class Image < String
  include Mongoid::Fields::Serializable

  def serialize(object) 
    object.to_s
  end
  def deserialize(object)
    Image.new(object || '')
  end 

end