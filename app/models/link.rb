class Link
  include Mongoid::Document

  field :uri, type: String  # the URI of the entity we're linking to
  field :content_type, type: String  # mime type if there is one
end