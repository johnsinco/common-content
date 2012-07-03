require 'spec_helper'

describe 'About Us Page' do

  context 'About Us Page' do
    before do
      @about = Content.new(slug:'about-us', title:'About Us', body:'h4. About Us')
      @about.child_contents.build(slug:'staff', title:'Our People')
      @about.child_contents.build(slug:'charity', title:'Our Charitable Efforts')
      @about.child_contents.build(slug:'jobs', title:'Work for Us')
      @about.save!
    end
    it 'can make a content item with the necessary components' do
      @about.child_contents.count.should == 3
    end
    it 'can link to the staff resources' do
      staff = @about.child_contents.find('staff')
      staff.resources.build(name:'dave', kind:'person', uri:'/persons/dave')
      staff.resources.build(name:'bill', kind:'person', uri:'/persons/bill')
      staff.save!
      staff.reload
      staff.resources.count.should == 2
    end

    it 'child contents can be accessed by slug' do
      pending
      @about.should respond_to(:staff)
    end
    it 'child contents can be re-ordered' do
      @about.child_contents.first.slug.should == 'staff'
      @about.child_order = "charity, jobs, staff"
      @about.save!
      @about.child_contents.first.slug.should == 'charity'
      @about.child_contents.last.slug.should == 'staff'
    end
  end

end