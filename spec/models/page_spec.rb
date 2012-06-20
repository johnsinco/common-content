require 'spec_helper'

describe Page do
  let(:content) { Content.build('image-holder', 'field :img, type: Image')}

  it "has the fields needed for a webpage" do
    should respond_to(:title)
    should respond_to(:slug) 
    should respond_to(:description)
  end
  it "can link to a list of contents for the page" do
    content.save!
    should respond_to(:contents)
    subject.contents << content
    subject.save!
    subject.reload
    subject.contents.first.should == content
  end

  it "can order the content items explicitly" do
    c1 = Content.build('one', 'field :one, type: String')
    c2 = Content.build('two', 'field :two, type: Textile')
    c1.save!; c2.save!
    subject.contents << c1
    subject.contents << c2
    subject.save!
    subject.reload
    subject.ordered_contents.should == [c1, c2]
    subject.content_ids = [c2.id, c1.id]
    subject.save!; subject.reload
    subject.ordered_contents.should == [c2, c1]
  end
end