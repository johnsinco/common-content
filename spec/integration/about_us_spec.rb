require 'spec_helper'

describe 'About Us Page' do

  context 'About Us Page' do
    before do
      @about = Content.new(slug:'about-us')
      hero = @about.child_contents << Content::Entry.new(slug:'hero', body:'foo', required: true)
      bios = @about.child_contents << Content::Group.new(slug:'bios', required: true)
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
    it 'page groups can be re-ordered' do
    end
  end

end