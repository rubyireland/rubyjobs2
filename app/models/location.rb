class Location < ActiveRecord::Base
  NAMES = self.find(:all, :order => :name).map do |l|
    [l.name, l.id]
  end
  
  attr_accessible :name
  
	validates_presence_of :name
	has_many :jobs
end
