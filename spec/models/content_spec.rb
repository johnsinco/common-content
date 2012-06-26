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
      two = Content.new('foo')
      two.should be_invalid
    end
  end
end

class PageContentInstance 
end

class FaqContentInstance
end

class AboutUsPageInstance
end
