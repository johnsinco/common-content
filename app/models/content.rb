class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true


  field :title, type: String
  validates :title, presence: true

  field :body, type: Textile  # optional html block of text for this content

  embeds_one :seo  # optional SEO fields
  accepts_nested_attributes_for :seo   # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document

  embeds_many :resources   # optional 1-n resources like images, videos, REST urls, etc
  accepts_nested_attributes_for :resources # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document

  recursively_embeds_many  # optionaal 1-n embedded child Content objects, the editable field controls if user can change

  # embeds_one :constraint  # the constraints of what fields are required, what child objects can be defined and how many, etc.

  def self.find_by_slug(slug)
    Content.where(slug: slug).first
  end
end