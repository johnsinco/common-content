class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true
  key :slug

  field :required, type: Boolean, default: true # cannot be removed by user
  field :editable, type: Boolean, default: false # structure cannot be changed by user
  field :tags, type: Array, default: []  # array of strings

  recursively_embeds_many

  def method_missing(symbol)
  child(symbol) or super
  end

  def respond_to?(symbol, include_private = false)
  child(symbol) or super
  end

  def child(slug)
  child_contents.detect{|c| c.slug == slug}
 end

end