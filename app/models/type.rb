class Type < ActiveRecord::Base
  NAMES = self.find(:all, :order => :name).map do |t|
    [t.name, t.id]
  end
  
  attr_accessible :name
  
	validates_presence_of :name
	has_many :jobs
end
