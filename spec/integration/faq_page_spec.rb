require 'spec_helper'

describe 'Faq Page' do

  subject { Content.build('faq', defn)}

  it 'has a root content element called faq' do
    subject.slug.should == 'faq'
  end

  it 'has an entries element that contains a list of entries' do
    subject.should respond_to(:entries)
    subject.entries.build(slug: 'one', title: 'title 1', description: 'desc 1')
    subject.save
    subject.reload
    subject.entries.should have(1).entry
  end

  let(:defn) { "
    embeds_many :entries, :class_name => 'Definition'
  "}
end