class Issue < ApplicationRecord
    	belongs_to :user, optional: true
    		has_many :commentaris
            has_one_attached :file
            acts_as_votable
end
