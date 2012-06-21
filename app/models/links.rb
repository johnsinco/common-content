class Links < Array
  include Mongoid::Fields::Serializable

  def serialize(object) 
    object.to_a
  end
  def deserialize(object)
    Links.new(object || [])
  end 
end