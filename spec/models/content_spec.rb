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
    before(:all) do
      @a = Content.build('aaa', 'field :a, type: String', binding)
      @a.save
      @b = Content.build('bbb', 'field :b, type: String', binding)
      @b.save
    end
    it 'builds a unique instance for each call' do
      @a.class.name.should == 'Aaa'
      @a.should respond_to(:a)
      @a.should_not respond_to(:b)
      @a.fields.keys.should include('a')
      @a.fields.keys.should_not include('b')
      @b.class.name.should == 'Bbb'
      @b.should respond_to(:b)
      @b.should_not respond_to(:a)
      @b.fields.keys.should include('b')
      @b.fields.keys.should_not include('a')
    end
    it 'allows building multiple different instances, getting all' do
      Content.all.entries.should include @a and include @b
    end
  end
end