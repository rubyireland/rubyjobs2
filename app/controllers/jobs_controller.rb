class JobsController < ApplicationController

	def index
		@jobs = Job.recent.search_for(params[:search])

		respond_to do |format|
			format.html
			format.rss
			format.js
		end
	end

	def show
		@job = Job.find(params[:id])

		respond_to do |format|
			format.html
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
