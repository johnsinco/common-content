require 'spec_helper'

describe 'About Us Philanthropy Page' do

  subject { Content.build('philanthropy', defn)}

  it 'has the required simple content blocks for a page' do
    subject.should respond_to(:summary)
    subject.should respond_to(:title)
  end

  it 'has a place for the image' do
    subject.should respond_to(:image)
    subject.image.should be_a(Image)
  end

  let(:defn) { "
    field :title, type: String
    field :summary, type: String
    field :image, type: Image
  "}
end