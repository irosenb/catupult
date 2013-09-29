class User < ActiveRecord::Base

	def has_phone_number?
		phone_number != nil
	end

	def jawbone_client
		@jawbone_client ||= Jawbone::Client.new(token)
	end

	def trends
		@trends ||= jawbone_client.trends
	end

	def sleep_trends
		@sleep_trends ||= trends["data"]["items"]
	end

	def get_sleep(id)
		recent_sleep = jawbone_client.sleep(id)
		trends_sleep = sleep_trends

		percentage = (recent_sleep/trends_sleep) * 100
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
