class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  # attr_protected :slug
  has_one :definition, :class_name => 'Content::Definition', autosave: true
  accepts_nested_attributes_for :definition
  # attr_protected :definition

  validates :slug, :definition,  presence: true 

  def defn=(defn)
    build_definition(definition: defn)
  end

  def defn
    definition.definition
  end

  def self.all_entries
    Content::Definition.all.each {|defn| define_class(defn.content_type, defn.definition) }
    Content.all
  end

  def self.build(slug, defn)
    # create an object from the name
    classname = classify(slug)
    define_class(classname, defn)
    const_get(classname).new(slug: slug, defn: defn)
  end

  def renovate(defn)
    self.definition.definition = defn
    Content.define_class(self.class.name, defn)
  end

  def self.classify(slug)
    slug.gsub(/-/, '_').classify
  end

  def self.define_class(classname, defn)
    # create the dynamic class from the definition
    binding.eval("class #{classname} < Content; #{defn}; end")
  end

  def data_fields
    fields.reject { |k,v| /^_.*|slug|definition|created_at|updated_at/ =~ k  }
  end

  class Definition
    include Mongoid::Document
    belongs_to :content, polymorphic: true
    field :slug
    field :definition, type: String
  end
end