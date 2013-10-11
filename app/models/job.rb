require 'securerandom'

class Job < ActiveRecord::Base
	validates_presence_of :company, :email, :type_id, :location_id, :title, :description, :how_to_apply
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"

	attr_accessible :title, :company, :url, :email, :location_id, :type_id, :how_to_apply, :description

	belongs_to :type
	belongs_to :location

	searchable_on :company, :title, :description, :how_to_apply, :location_name, :type_name #see http://github.com/wvanbergen/scoped_search/tree/master
	scope :recent, lambda { { :conditions => ['created_at > ?', 8.week.ago], :order => 'created_at DESC' } }

	before_save :set_key, :set_http

	private

	def set_key
		self.key = SecureRandom.hex(8) if self.key.nil?
	end

	def set_http
    unless self.url.start_with?('http://') || self.url.start_with?('https://')
		  self.url = 'http://' + self.url
    end
	end
end
