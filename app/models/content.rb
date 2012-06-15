class Content
  include Mongoid::Document

  field :slug, type: String
  key :slug
  has_one :definition, :class_name => 'Content::Definition', autosave: true
  accepts_nested_attributes_for :definition

  validates :slug, :definition,  presence: true 

  def defn=(defn)
    build_definition(definition: defn)
  end

  def defn
    definition.definition
  end

  def self.build(slug, defn)
    # create an object from the name
    classname = slug.gsub(/-/, '_').classify
    define_class(classname, defn)
    const_get(classname).new(slug: slug, defn: defn)
  end

  def self.define_class(classname, defn)
    # create the dynamic class from the definition
    binding.eval("class #{classname} < Content; #{defn}; end")
  end

  class Definition
    include Mongoid::Document
    belongs_to :content
    field :definition, type: String
 end
end