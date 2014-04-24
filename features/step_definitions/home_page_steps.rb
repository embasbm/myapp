Given(/^there's a job with "(.*?)" with "(.*?)" name$/) do |name|
  @job = FactoryGirl.create(:job, name: name)
end

When(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see the "(.*?)" post$/) do |name|
  @job = Job.find_by_name(name)

  page.should have_content(@job.name)
end