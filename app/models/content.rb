class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true
  key :slug

  field :required, type: Boolean, default: true # cannot be removed by user
  field :editable, type: Boolean, default: false #  children are fixed, cannot be user modified
  field :tags, type: Array, default: []  # array of strings

  embeds_one :seo, class_name: 'Seo'  # optional SEO fields
  embeds_one :media, class_name: 'Media'  # optional media element, might move this into children?
  recursively_embeds_many

end