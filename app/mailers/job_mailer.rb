class JobMailer < ActionMailer::Base
  default from: "jobs@rubyjobs.ie"
  
  def confirmation_email(job)
    @job = job
		mail(:to => job.email, :subject => "[RubyJobs.ie] Your job is now live (##{job.id})")
	end
end
