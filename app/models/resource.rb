class Resource
  include Mongoid::Document

  field :name, type: String
  field :uri, type: String  # the URI of the entity we're linking to
  field :content_type, type: String  # mime type if there is one
end