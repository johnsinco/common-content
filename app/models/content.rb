class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true
  key :slug

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