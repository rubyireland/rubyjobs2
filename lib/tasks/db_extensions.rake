namespace :db do
  desc 'Drops, then recreates and carries out migrations on your database.' 
  task :clean => ['db:drop', 'db:create', 'db:migrate']

	desc "Populate database with locations"
	task(:seed_locations => :environment) do
		locations = ['Work from home', 'Other']
		locations += %w{Antrim Armagh Carlow Cavan Clare Cork Derry Donegal Down Dublin Fermanagh Galway Kerry Kildare Kilkenny Laois Leitrim Limerick Longford Louth Mayo Meath Monaghan Offaly Roscommon Sligo Tipperary Tyrone Waterford Westmeath Wexford Wicklow}
		locations.each {|name| Location.create(:name => name) }
	end
	
	desc "Populate database with locations"
	task(:seed_types => :environment) do
		['Contract', 'Permanent', 'Other'].each {|name| Type.create!(:name => name) }
	end
	
	desc "Populate database with the minimum essential data"
  task(:seed_minimum => :environment) do
    Rake::Task['db:clean'].invoke
		Rake::Task['db:seed_locations'].invoke
		Rake::Task['db:seed_types'].invoke
	end

  desc "Populate database with some records to get you up and running."
  task(:seed => :environment) do
    Rake::Task['db:seed_minimum'].invoke

    Job.create!(:title => 'Merb Developer',
      :company => 'Titus Inc.', :url => 'http://www.titusonmerb.com/',
      :email =>'info@testtitus.com', :location_id => Location.all[0].id, :type_id => 1,
      :how_to_apply => 'Email us at jobs [at] testtitus [dot] com',
      :description => 'Super job for the right person.')

    Job.create!(:title => 'Rails Developer',
      :company => 'Peter Consulting', :url => 'http://peteronmerb.com/',
      :email =>'info@testpeter.com', :location_id => Location.all[1].id, :type_id => 1,
      :how_to_apply => 'Fill out the pplication form on our website',
      :description => 'Needs 1 year of development experience.')

			1.upto(30) do |i|
				job = Job.create!(:title => "Another Job #{i}",
		  		:company => "Company #{i}", :url => 'http://somewebsite.com/',
		      :email =>'info@somewebsite.com', :location_id => Location.all[1].id, :type_id => 2,
		      :how_to_apply => "Call us on 01-123456#{i}",
		      :description => 'Some description here')
		    job.created_at = (i*1.5).days.ago
		    job.save!
			end
  end
end
