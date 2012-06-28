require 'spec_helper'

describe Content do
  subject { Content.new(slug:'subject')}
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
      Content::Entry.should be
    end
    it 'has a Entity type' do
      pending 'for referring to Personalities, Funds, etc.'
      Content::Entity.should be
    end
  end

  context 'composition' do
    it 'can add child content items' do
      subject.child_contents << Content.new(slug:'kidA', body:'h1. foo')
      subject.save!; subject.reload
      subject.child_contents.count.should == 1
    end
    it 'children can be of subtypes' do
      subject.child_contents << Group.new(slug:'kidB')
      entry = Entry.new(slug:'kidA', body:'h1. foo')
      entry.should be_valid
      subject.child_contents << entry
      subject.save!; subject.reload
      subject.child_contents.first.should be_a Group
      subject.child_contents.second.should be_a Entry
      subject.child_contents.second.body.should == 'h1. foo'
    end
  end

  context 'About Us Page' do
    before(:all) do
      @about = Content.new(slug:'about-us')
      hero = @about.child_contents << Content::Entry.new(slug:'hero', body:'foo')
      bios = @about.child_contents << Content::Group.new(slug:'bios')
      phil = @about.child_contents << Content::Group.new(slug:'phil')
      @about.save!
    end
    it 'can make a content item with the necessary components' do
      @about.save!
      @about.child_contents.count.should == 3
    end
    it 'child contents can be accessed by slug' do
      pending
      @about.should respond_to(:hero)
    end
    it 'content children should have the right type' do
      pending 
      @about.hero.should be_a Content::Entry
      @about.bios.should be_a Content::Group
      @about.phil.should be_a Content::Group
    end
    it 'page groups can be added' do
      @about.child_contents << Group.new(slug:'third')
      @about.save!
      @about.reload
      @about.child_contents.last.slug.should == 'third'
    end
    it 'page groups can be removed' do
    end
    it 'page groups can be re-ordered' do
    end
  end
end
end
