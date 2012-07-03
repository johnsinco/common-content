class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true
  key :slug

  field :title, type: String
  validates :title, presence: true

  field :body, type: Textile  # optional html block of text for this content

  embeds_one :seo  # optional SEO fields
  accepts_nested_attributes_for :seo   # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document

  embeds_many :resources   # optional 1-n resources like images, videos, REST urls, etc
  accepts_nested_attributes_for :resources # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document

  recursively_embeds_many  # optionaal 1-n embedded child Content objects, the editable field controls if user can change
  accepts_nested_attributes_for :child_contents # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document

  # embeds_one :constraint  # the constraints of what fields are required, what child objects can be defined and how many, etc.

  def ancestry
    parent_content ? parent_content.ancestry << id : [id]
  end

  def self.find_by_ancestry(ancestry = nil, id)
    return self.find(id) unless ancestry
    parent = Content.find(ancestry.shift)
    while(parent_slug = ancestry.shift and parent_slug != id) do
      parent = parent.child_contents.find(parent_slug)
    end if parent
    parent.child_contents.find(id)
  end

  def child_order=(order)
    return unless order
    order = order.split(',')
    order.each {|e| e.strip!}
    self.child_contents = self.child_contents.sort_by {|kid| order.find_index(kid.id) }
  end

  def to_param
    parent_content ? parent_content.to_param + '/' + id : id
  end

end