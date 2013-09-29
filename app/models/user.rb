class User < ActiveRecord::Base
	def jawbone_client
		@jawbone_client ||= Jawbone::Client.new(token)
	end

	def sleep_trends
		jawbone_client.trends["data"]["items"]["s_asleep_time"]
	end

	def get_sleep(id)
		new_sleep = jawbone_client.sleep(id)
		trends_sleep = sleep_trends

		percentage = (new_sleep/trends_sleep) * 100
		if percentage < 50 
			# Do something here 
		end	 
	end

	def tired_detector
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
