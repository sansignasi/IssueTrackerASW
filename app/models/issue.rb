class Issue < ApplicationRecord
    	belongs_to :user, optional: true
    	has_many :comments, dependent: :destroy
        has_one_attached :file
        acts_as_votable
end
