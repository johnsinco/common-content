class Content
  include Mongoid::Document

  field :slug, type: String
  has_one :definition, :class_name => 'Content::Definition', autosave: true
  accepts_nested_attributes_for :definition

  validates :slug, :definition,  presence: true 

  def defn=(defn)
    build_definition(definition: defn)
  end

  def defn
    definition.definition
  end

  def self.build(slug, defn, binding)
    # create an object from the name
    classname = slug.gsub(/-/, '_').classify
    # create the dynamic class from the definition
    binding.eval("class #{classname} < Content; #{defn}; end")
    classname.constantize.new(slug: slug, defn: defn)
  end

  class Definition
    include Mongoid::Document
    belongs_to :content
    field :definition, type: String
 end
end