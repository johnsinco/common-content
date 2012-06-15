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
    before(:each) do
      @a = Content.build('aaa', 'field :a, type: String')
      @a.save
      @b = Content.build('bbb', 'field :b, type: String')
      @b.save
    end
    it 'builds a unique instance for each call' do
      @a.class.name.should == 'Content::Aaa'
      @a.should respond_to(:a)
      @a.should_not respond_to(:b)
      @a.fields.keys.should include('a')
      @a.fields.keys.should_not include('b')
      @b.class.name.should == 'Content::Bbb'
      @b.should respond_to(:b)
      @b.should_not respond_to(:a)
      @b.fields.keys.should include('b')
      @b.fields.keys.should_not include('a')
    end
    it 'allows building multiple different instances, getting all' do
      Content.all.entries.should include @a and include @b
    end
    context '#save' do
      it 'allows different instance-types to be saved to mongo' do
        one = Content.build('one', 'field :one, type: String')
        two = Content.build('two', 'field :two, type: String')
        one.save; two.save
        uno = Content.find('one')
        dos = Content.find('two')
        uno.class.name.should == 'Content::One'
        dos.class.name.should == 'Content::Two'
      end
    end
    context '#find' do
      it 'can lookup an instance by slug' do
        one = Content.build('one', 'field :one, type: String')
        one.save
        Content.find('one').should be
      end
    end
  end
end