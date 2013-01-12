require 'factory_girl'

FactoryGirl.define do
  factory :job do
    company       'ACME Inc.'
    url           'www.acme.org'
    email         'jobs@acme.org'
    title         'Rails developer required for greenfield project'
    description   'We are planning on revamping our online store and need someone to build the Rails application'
    how_to_apply  'Email jobs@acme.org or call 01-1234567'
    location
    type
  end
  
  factory :location do
    name 'Dublin'
  end
  
  factory :type do
    name 'Contract'
  end
end

