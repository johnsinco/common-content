class Definition
  include Mongoid::Document

  field :slug
  field :title
  field :description
  field :category, default: 'General'
  field :featured, type: Boolean, default: false
end