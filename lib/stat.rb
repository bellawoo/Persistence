class Stat < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :wins, :losses, :draws
end