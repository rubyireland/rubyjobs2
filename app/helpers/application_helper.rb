module ApplicationHelper
  def set_focus_to_id(id)
     javascript_tag("$('##{id}').focus()")
   end

   def param_present?(param_name)
     params[param_name] && !params[param_name].blank?
   end

   def main_nav
     if params[:controller] == 'jobs' and ['new', 'edit'].include?(params[:action])
       link_to('<< Return to jobs list', :root)
     else
       link_to('Post a new job >>', new_job_path)
     end
   end
   
   def rss_link
     param_present?(:search) ? jobs_url(:rss, rss_link_attributes) : "http://feeds.feedburner.com/rubyjobsireland"
   end

   def rss_link_attributes
     param_present?(:search) ? {:search => "#{params[:search]}"} : {}
   end
end
