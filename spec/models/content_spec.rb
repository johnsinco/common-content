require 'spec_helper'

describe Content do
  subject { Content.new(slug:'subject', title:'subject')}
  context "basic fields" do
    it 'accepts a slug' do
      subject.should respond_to(:slug)
    end
    it 'requires slug' do
      subject.slug = nil
      subject.should be_invalid
    end
    it 'slug must be unique' do
      subject.slug = 'foo'
      subject.title = 'foo'
      subject.save!
      two = Content.new(slug:'foo', title:'foo')
      two.should be_invalid
    end
    it 'requires title' do
      Content.new(slug:'blargh').should be_invalid
      Content.new(slug:'blargh', title:'blargh').should be_valid
    end
  end

  context "embedded children" do
    it 'has a child content collection' do
      subject.slug = 'parent'
      subject.should respond_to(:child_contents)
      subject.child_contents.build(slug:'first')
      subject.child_contents.build(slug:'second')
  end


  context 'composition' do
    it 'can add child content items' do
      subject.child_contents << Content.new(slug:'kidA', title:'kidA', body:'h1. foo')
      subject.save!; subject.reload
      subject.child_contents.count.should == 1
    end
  end
end
end
