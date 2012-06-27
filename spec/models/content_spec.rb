require 'spec_helper'

describe Content do

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
      subject.save!
      two = Content.new(slug:'foo')
      two.should be_invalid
    end
  end

  context "embedded children" do
    it 'has a child content collection' do
      subject.slug = 'parent'
      subject.should respond_to(:child_contents)
      subject.child_contents.build(slug:'first')
      subject.child_contents.build(slug:'second')
  end

  context 'content types' do
    it 'has a Page type' do
      pending 'for a full-fledged page with title, seo, etc and child content'
      Content::Page.should be
    end
    it 'has a Group type' do
      pending 'for a group of other Content types, with a title'
      Content::Group.should be
    end
    it 'has a Media type' do
      pending 'for image, video, podcast, etc'
      Content::Media.should be
    end
    it 'has a Entry type' do
      pending
      Content::Entry.should be
    end
    it 'has a Entity type' do
      pending 'for referring to Personalities, Funds, etc.'
      Content::Entity.should be
    end
  end

  context 'About Us Page' do
    before(:all) do
      subject.slug = 'about-us'
      hero = subject.child_contents << Content::Entry.new(slug:'hero', body:'foo')
      bios = subject.child_contents << Content::Group.new(slug:'bios')
      phil = subject.child_contents << Content::Group.new(slug:'phil')
    end
    it 'can make a content item with the necessary components' do
      subject.save!
      subject.child_contents.count.should == 3
    end
    it 'child contents can be accessed by slug' do
      pending
      subject.should respond_to(:hero)
    end
    it 'content children should have the right type' do
      pending 
      subject.hero.should be_a Content::Entry
      subject.bios.should be_a Content::Group
      subject.phil.should be_a Content::Group
    end
  end
end
end
