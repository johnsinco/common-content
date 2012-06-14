require 'spec_helper'

describe Content do
  it 'requires a :slug and :definition to create' do
    Content.new(slug:'foo', defn:'# none').should be_valid
    Content.new.should_not be_valid
  end
  it 'provides direct access to the content definition' do
    c = Content.new(slug:'foo', defn:'# none')
    c.definition.definition.should == '# none'
  end
  context '#build' do
    it 'builds a unique instance for each call' do
      a = Content.build('aaa', 'field :a, type: String', binding)
      a.class.name.should == 'Aaa'
      a.should respond_to(:a)
      a.should_not respond_to(:b)
      a.fields.keys.should_not include(:b)
      b = Content.build('bbb', 'field :b, type: String', binding)
      b.class.name.should == 'Bbb'
      b.should respond_to(:b)
      b.should_not respond_to(:a)
    end
  end
end