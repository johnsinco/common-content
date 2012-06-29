class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true
  key :slug

  field :title, type: String
  validates :title, presence: true

  field :body, type: Textile  # optional html block of text for this content
  
  embeds_one :seo, class_name: 'Seo'  # optional SEO fields

  embeds_many :resources   # optional 1-n resources like images, videos, REST urls, etc

  recursively_embeds_many  # optionaal 1-n embedded child Content objects, the editable field controls if user can change

  # embeds_one :constraint  # the constraints of what fields are required, what child objects can be defined and how many, etc.
end