class Page
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String

  field :title, type: String
  field :description, type: String

  has_and_belongs_to_many :contents, :class_name => 'Content', :inverse_of => nil

  def ordered_contents
    contents.sort { |a,b| content_ids.index(a.id) <=> content_ids.index(b.id) }
  end
end