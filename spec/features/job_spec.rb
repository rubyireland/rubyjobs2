require 'spec_helper'

describe 'viewing  jobs' do
  before do
    visit '/jobs'
  end

  it 'should have a text' do
    page.should have_text('The latest Ruby jobs in Ireland')
  end
end


describe 'editing a  job' do
  before do
    job = create :job
    visit "/jobs/#{job.id}/edit?key=#{job.key}"
  end

  it 'should have a text' do
    page.should  have_selector("input[type=submit][value='Delete Job']")
  end

end
