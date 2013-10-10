describe Job do
	describe "when creating a job" do
		it "should have a key" do
			@job = create(:job)
			@job.key.should_not be_nil
		end

		it "should have a unique key" do
			@job1 = create(:job)
			@job2 = create(:job)
			@job1.key.should_not == @job2.key
		end

		it "should add http on url" do
			@job = create(:job)
			@job.url.start_with?("http://").should == true
		end

		it "should not add http" do
			@job = create(:job)
			expected_url = "http://www.test.org"
			@job.url = expected_url
			@job.save!
			@job.url.should == expected_url
		end
	end

	describe "when saving a job" do
		it "the key should be the same as before the save" do
			@job1 = create(:job)
			pre_save_key = @job1.key
			@job1.save!
			@job1.key.should == pre_save_key
		end
	end

	describe "validations" do
		it "should be valid with valid attributes" do
			create(:job).should be_valid
		end

		it { should validate_presence_of(:company) }
		it { should validate_presence_of(:email) }
		it { should validate_presence_of(:type_id) }
		it { should validate_presence_of(:location_id) }
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:description) }
		it { should validate_presence_of(:how_to_apply) }

		it "should ensure that email is a valid email" do
			@job = build(:job, :email => 'invalid@email')
			@job.should_not be_valid
			@job.should have(1).error_on(:email)
		end
	end

	describe "searching" do
		it "should be searchable" do
			Job.should respond_to(:search_for)
		end

		it "should search the company" do
			Job.search_for('google').length.should == 0
			create(:job, :company => 'Google')
			Job.search_for('google').length.should == 1
		end

		it "should search the title" do
			Job.search_for('contract').length.should == 0
			create(:job, :title => 'Developer needed (contract)')
			Job.search_for('contract').length.should == 1
		end

		it "should search the description" do
			Job.search_for('june 2009').length.should == 0
			create(:job, :description => 'This job starts in June 2009')
			Job.search_for('june 2009').length.should == 1
		end

		it "should search the how_to_apply" do
			Job.search_for('jobs@acme.org').length.should == 0
			create(:job, :how_to_apply => 'email us - jobs@acme.org')
			Job.search_for('jobs@acme.org').length.should == 1
		end

		it "should search the location" do
			Job.search_for('dublin').length.should == 0
			create(:job, :location => create(:location, :name => 'Dublin'))
			Job.search_for('dublin').length.should == 1
		end

		it "should search the type" do
			Job.search_for('permanent').length.should == 0
			create(:job, :type => create(:type, :name => 'Permanent'))
			Job.search_for('permanent').length.should == 1
		end
	end
end
