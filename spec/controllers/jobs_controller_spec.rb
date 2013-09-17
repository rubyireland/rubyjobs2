require 'spec_helper'

describe JobsController do
	integrate_views

	describe "the index action" do
		before do
			@job = create(:job)
			get :index
		end

		it "should render correctly" do
			response.should be_success
			response.should render_template 'index'
		end

		it "should render correctly as RSS" do
			get :index, format: :rss
			response.should be_success
		end

		it 'should render correctly as JSON' do
			get :index, format: :json
			response.should be_success
		end

		it 'should respond correctly to JSONP' do
			get :index, callback: 'someCallback', format: :js
			response.should be_success
			jsonp = response.body
			jsonp[0..12].should == 'someCallback('
		end

		it "should assign a jobs collection" do
			assigns[:jobs].should_not be_nil
			assigns[:jobs][0].should == @job
		end

		describe "when there are jobs to display" do
			it "should list the most recent jobs" do
				response.body.should have_selector("ul#job_list")
			end
		end

		describe "when there are no jobs to display" do
			before do
				Job.destroy_all
				get :index
			end

			it "should show a message indicating that there are no jobs" do
				response.body.should have_selector("span#no_jobs")
			end

			it "should not display any jobs in the table" do
				get :index
				response.body.should_not have_selector("tr.job")
			end
		end

		describe "when a search term is provided" do
			it "should render correctly" do
				get :index, {:search => 'merb'}
				response.should be_success
				response.should render_template 'index'
			end

			it "should link to an RSS feed for the search term" do
				get :index, {:search => 'merb'}
				pending
				response.body.should have_text(/a\shref=\"http.+jobs\.rss\?search=merb"/)
				response.body.should have_text(/RSS feed\s* for 'merb'/)
			end

			it "should assign jobs which contain the search term"
			it "should not assign jobs which do not contain the search term"
		end

		describe "when a search term including << is provided" do
			before do
			  pending
				get :index, {:search => 'merb<<'}
			end

			it "should render correctly" do
			  pending
				response.should be_success
			end

			it "should link to an RSS feed for the search term" do
			  pending
				lt = CGI.escape('<')

				response.should have_text(/a\shref=\"http.+jobs\.rss\?search=merb#{lt}#{lt}"/)
				response.should have_text(/RSS feed\s* for 'merb&lt;&lt;'/)
			end
		end
	end

	describe "the show action" do
		before do
			@job = create(:job)
			get 'show', :id => @job
		end

		it "should be successful" do
			response.should be_success
			response.should render_template 'show'
		end

		it "should assign a job" do
			assigns[:job].should == @job
		end
	end

	describe "the new action" do
		before do
			get :new
		end

		it "should be successful" do
			response.should be_success
			response.should render_template 'new'
		end

		it "should assign a job" do
			assigns[:job].should_not be_nil
			assigns[:job].should be_an_instance_of Job
		end

		it "should have more specs"
	end

	describe "the edit action" do
		describe "with a valid action key" do
			before do
				@job = create(:job)
				get :edit, { :id => @job.id, :key => @job.key }
			end

			it "should be successful" do
				response.should be_success
				response.should render_template 'edit'
			end

			it "should assign a job" do
				assigns[:job].should == @job
			end

			it "should display the edit form with a hidden key field" do
				response.body.should have_selector("form.edit_job") do
					with_tag "input[type=hidden][name=key]", :content => @job.key
				end
			end
		end

		describe "with no action key" do
			before do
				@job = create(:job)
				get :edit, { :id => @job.id }
			end

			it "should redirect to homepage" do
				response.should redirect_to('/')
			end
		end

		describe "with an invalid action key" do
			before do
				@job = create(:job)
				get :edit, { :id => @job.id, :key => "abc#{@job.key}" }
			end

			it "should redirect to homepage" do
				response.should redirect_to('/')
			end
		end
	end

	describe "the create action" do
	  let(:valid_attributes) { attributes_for(:job, :location_id => create(:location).id, :type_id => create(:type).id) }
		describe "with valid attributes" do
			it "should create and redirect to the new job" do
				Job.count.should == 0
				post 'create', { :job => valid_attributes }
				Job.count.should == 1
				response.should be_redirect
				flash[:notice].should_not == nil
			end

			it "should create and redirect to the job with an edit link" do
				pending
			end

			it "should send an email" do
			  expect {
          post :create, job: valid_attributes
        }.to change(ActionMailer::Base.deliveries,:count)
			end
		end

		describe "with invalid attributes" do
		  let(:invalid_attributes) { valid_attributes.except(:title) }
			it "should not create a job" do
			  expect {
          post :create, job: invalid_attributes
        }.to_not change(Job,:count)
			end

			it "should show an error message" do
			  post :create, job: invalid_attributes
				response.body.should have_selector('div.errorExplanation')
				response.should render_template :new
			end
		end

		describe "with a non-blank honeypot" do
			before do
				post 'create', { :job => valid_attributes, :sticky_goo_pot => "I'm a spammer's computer." }
			end

			it "should not create a job" do
				Job.count.should == 0
			end

			it "should redirect to the new job action" do
				response.should be_redirect
			end
		end
	end

	describe "the update action" do
		it "should have specs"
	end

	describe "the destroy action" do
		context 'given a job exists' do
			before :each do
				@job = Job.new
				controller.stub(:find_job_with_key).and_return(@job)
			end
			it 'should delete it' do
				@job.should_receive(:destroy)
				post 'destroy', {job: {id: 1}}
			end
		end
	end

end
