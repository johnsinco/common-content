class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  validates :slug, presence: true, uniqueness: true
  key :slug

  field :title, type: String
  validates :title, presence: true

  field :body, type: Textile  # optional html block of text for this content

  embeds_one :seo, class_name: 'Content::Seo'  # optional SEO fields
  accepts_nested_attributes_for :seo   # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document

  embeds_many :resources, class_name: 'Content::Resource'   # optional 1-n resources like images, videos, REST urls, etc
  accepts_nested_attributes_for :resources, allow_destroy: true # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document
  attr_accessor :resource_order

  recursively_embeds_many  # optionaal 1-n embedded child Content objects, the editable field controls if user can change
  accepts_nested_attributes_for :child_contents, allow_destroy: true # mongoid BUG see http://stackoverflow.com/questions/9392315/mongoid-and-nested-form-for-embeds-one-document
  attr_accessor :child_order

  # embeds_one :constraint  # the constraints of what fields are required, what child objects can be defined and how many, etc.

  # perform the re-order of embedded children and resources here as you cant re-order and add at thesame time
  before_save :reorder_children
  before_save :reorder_resources

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

  def reorder_children
    return unless @child_order
    order = @child_order.split(',')
    order.each {|e| e.strip!}
    self.child_contents = self.child_contents.sort_by {|kid| order.index(kid.id) or -1 }
  end

  def reorder_resources
    return unless @resource_order
    order = @resource_order.split(',')
    order.each {|e| e.strip!}
    self.resources = self.resources.sort_by {|res| order.index(res.id) or -1 }
  end

  def to_param
    parent_content ? parent_content.to_param + '/' + id : id
  end

  class Resource
    include Mongoid::Document
    embedded_in :content

    field :slug, type: String
    field :uri, type: String  # the URI of the entity we're linking to
    field :content_type, type: String  # mime type if there is one
  end

  class Seo
    include Mongoid::Document
    embedded_in :content

    field :description, type: String
    field :keywords, type: String
    field :metatitle, type: String
    # validates :description, :keywords, :metatitle, presence: true
  end
end