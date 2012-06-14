class Content
  class Html
    include Mongoid::Fields::Serializable
    def deserialize(object)
      object["text"]
    end
    def serialize(object)
      { "text" => object }
    end
  end
end