module RedCloth
  class TextileDoc < String
    include Mongoid::Fields::Serializable
  end 
  # def serialize(object) 
  #   object.to_s
  # end
  # def deserialize(object)
  #   RedCloth.new(object)
  # end
end