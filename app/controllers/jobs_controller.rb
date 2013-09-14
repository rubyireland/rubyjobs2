class JobsController < ApplicationController

	def index
		@jobs = Job.recent.search_for(params[:search])

		respond_to do |format|
			format.html
			format.rss
			if params[:callback] #jsonp
     		format.js { render json: @jobs, callback: params[:callback] }
		   else
		   	format.json { render json: @jobs }
		  end
		end
	end

	def show
		@job = Job.find(params[:id])

		respond_to do |format|
			format.html
		end
	end

	def new
		@job = Job.new

		respond_to do |format|
			format.html
		end
	end

	def edit
		find_job_with_key
	end

	def create
		if !params[:sticky_goo_pot].blank? #houston, we have a spammer
			redirect_to :action => 'new'
		else
			@job = Job.new(params[:job])
			@types = Type.all
			@locations = Location.all

			respond_to do |format|
				if @job.save
					JobMailer.confirmation_email(@job).deliver

					flash[:notice] = 'Job was successfully created.'
					format.html { redirect_to :action => 'show', :id => @job.id, :key => @job.key }
				else
					format.html { render :action => "new" }
				end
			end
		end
	end

	def update
		find_job_with_key

		unless @job.nil?
			respond_to do |format|
				if @job.update_attributes(params[:job])
					flash[:notice] = 'Job was successfully updated.'
					format.html { redirect_to :action => 'show', :id => @job.id, :key => @job.key }
				else
					format.html { render :action => "edit" }
				end
			end
		end
	end

	def destroy
		find_job_with_key

		unless @job.nil?

			@job.destroy

			respond_to do |format|
				format.html { redirect_to(jobs_url) }
			end
		end
	end

	private

	def find_job_with_key
		@job = Job.find_by_id_and_key(params[:id], params[:key])

		if @job.nil?
			flash[:notice] = "That job is no longer available"
			redirect_to(:root)
		end
	end
end
