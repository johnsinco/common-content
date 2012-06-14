require 'spec_helper'

describe Content do
  it 'requires a :slug and :definition to create' do
    Content.new(slug:'foo', defn:'# none').should be_valid
    Content.new.should_not be_valid
  end
end