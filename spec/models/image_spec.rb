require 'spec_helper'

describe Image do
  let(:content) { Content.build('image-holder', 'field :img, type: Image')}
  it 'can hold an image url' do
    Image.new('foo.png').should == 'foo.png'
  end
  it 'can be included in a Content item' do
    content.img = 'foo.png'
    content.save
    c = Content.find(content.id)
    c.img.class.to_s.should == 'Image'
    c.img.should == 'foo.png'
  end
end