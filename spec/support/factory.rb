require 'factory_girl'

#Factory.define :job do |job|
#	job.company 			'ACME Inc.'
#	job.url						'www.acme.org'
#	job.email		 			'jobs@acme.org'
#	job.type_id	 			{ |type| type.association(:type) }
#	job.location_id 	{ |location| location.association(:location) }
#	job.title  				'Rails developer required for greenfield project'
#	job.description 	'We are planning on revamping our online store and need someone to build the Rails application'
#	job.how_to_apply  'Email jobs@acme.org or call 01-1234567'
#end

Factory.define :location do |location|
  location.name 'Dublin'
end

#Factory.define :type do |type|
#  type.name 'Contract'
#end