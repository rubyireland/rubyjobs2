class AddRemoteOptionToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :remote_option, :boolean, default: false
  end
end
