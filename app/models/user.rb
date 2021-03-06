class User < ApplicationRecord
	has_many :issues
	has_many :comments
	require 'securerandom'
	acts_as_voter
	def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			if user.token == nil then
				user.token = "asw_"+SecureRandom.urlsafe_base64
			end
			user.first_name = auth.info.first_name
			user.last_name = auth.info.last_name
			user.email = auth.info.email
			user.picture = auth.info.image
			user.save!
		end
	end
end