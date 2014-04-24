require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :name => "MyString",
      :predecessor_id => 1
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", jobs_path, "post" do
      assert_select "input#job_name[name=?]", "job[name]"
      assert_select "input#job_predecessor_id[name=?]", "job[predecessor_id]"
    end
  end
end
