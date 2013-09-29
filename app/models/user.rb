class User < ActiveRecord::Base
	def jawbone_client
		@jawbone_client ||= Jawbone::Client.new(token)
	end

	def trends
		jawbone_client.trends
	end

	def get_sleep(id)
		sleep = jawbone_client.sleep(id)
		
	end

	def self.find_or_create_from_jawbone(auth)
		if user = where(uid: auth['uid']).first
			user.token = auth['credentials']['token']
			user.save!
		else
			user = create_from_jawbone(auth)
		end
		user
	end

	def self.create_from_jawbone(auth)
		create! do |user|
			user.uid = auth['uid']
			user.token = auth['credentials']['token']
			user.first_name = auth['info']['first_name']
			user.last_name = auth['info']['last_name']
		end
	end
end
