require 'spec_helper'

describe 'Fund Landing Page' do

  subject { Content.build('FundLandingPage', defn)}

  it 'has the required simple content blocks for fund-landing' do
    subject.should respond_to(:synopsis)
    subject.should respond_to(:featured_synopsis)
    subject.should respond_to(:morningstar_synopsis)
    subject.should respond_to(:featured_filter)
  end

  it 'has an array of text featured fund highlights' do
    subject.should respond_to(:featured_highlights)
    subject.featured_highlights.should be_a(Array)
  end

  let(:defn) { "
    field :slug, type: String
    field :title, type: String
    field :synopsis, type: String
    field :featured_synopsis, type: String
    field :morningstar_synopsis, type: String
    field :featured_filter, type: String
    field :featured_highlights, type: Array, default: []
  "}
end