class User < ActiveRecord::Base

	def has_phone_number?
		phone_number != nil
	end

	def jawbone_client
		@jawbone_client ||= Jawbone::Client.new(token)
	end
	# def sleep_trends
	# 	jawbone_client.trends["data"]["items"]["s_asleep_time"]
	# end

	# def get_sleep(id)
	# 	new_sleep = jawbone_client.sleep(id)
	# 	trends_sleep = sleep_trends

	# 	percentage = (new_sleep/trends_sleep) * 100
	# 	if percentage < 50
	# 		# Do something here
	# 	end
	# end

	# def tired_detector
	# end

	def correct_phone_number
			if phone_number.start_with?("1")
				self.phone_number = phone_number.prepend("+")
			elsif phone_number.start_with?("+1")
			else
				self.phone_number = phone_number.prepend("+1")
			end
			phone_number.gsub('-', '')
			self.save
			phone_number
	end

	def send_text
		@client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

		message = @client.account.sms.messages.create(:body => "Hey, you seem a little down. Here's a cat pic to cheer you up. http://placekitten.com/#{rand(400..600)}/#{rand(400..600)}",
		    :to => "#{correct_phone_number}",     # Replace with your phone number
		    :from => "+18484562816")   # Replace with your Twilio number
		puts message.sid
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
