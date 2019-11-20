class Issue < ApplicationRecord
    		belongs_to :usuario, optional: true
            has_one_attached :file
            acts_as_votable
end
