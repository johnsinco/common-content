require 'spec_helper'

describe Content do
  context 'DSL builder language' do
    context 'Textile' do
      let(:textile_simple_dsl) {":html body_1 max:2000 required"}
      it 'allows a Content to be built using a Textile object' do
       c= Content.build('textile-one', textile_simple_dsl, binding)
       c.should respond_to(:body_1)
       c.body_1 = '<h1>Foo</h1>'
       c.save
       c = Content.find('textile-one')
       c.body_1.should == '<h1>Foo</h1>'
      end
    end
    context '#define_instance' do
      defn = <<-EOS
        :html body_1 max:20 
        :html body_2 required
        :html summary required max:2000 min:20
      EOS
      output = <<-EOS
        field :body_1, type: Html; validates :body_1, length: { maximum:2 }
        field :body_2, type: Html; validates :body_2, presence:true
        field :summary, type: Html; validates :summary, presence:true, length:{minimum:2,maximum:2000}
      EOS
      Content.define_instance(defn).should == output
    end
  end
end
