class Seo
  include Mongoid::Document

  field :description, type: String
  field :keywords, type: String
  field :metatitle, type: String

  # validates :description, :keywords, :metatitle, presence: true
end