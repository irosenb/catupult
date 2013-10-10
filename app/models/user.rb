class User < ActiveRecord::Base
	before_save (on: :update) do 
		unless self.phone_number.starts_with?
			
		end
		self.phone_number = phone_number.prepend("+1") 
	end

	def has_phone_number?
		phone_number != nil
	end

	def jawbone_client
		@jawbone_client ||= Jawbone::Client.new(token)
	end
	
	def twilio_client
		@twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
	end
	# def sleep_trends
	# 	jawbone_client.trends["data"]["items"]["s_asleep_time"]
	# end
	def mood
		jawbone_client.mood
	end

	def message(body)
		message = twilio_client.account.sms.messages.create(
				:body => "#{body}",
		    :to   => "#{phone_number}",
		    :from => "+18484562816")
		puts message.sid
	end

	def get_mood
		if mood["data"]["title"] == "Totally Done" or mood["data"]["title"] == "Dragging"
			self.send_text
		end
	end

	def tired_detector
	end

	def correct_phone_number
		phone_number.gsub('+1')
		phone_number.gsub('-', '')
		phone_number.gsub('(', '')
		phone_number.gsub(')', '')
		self.save
		phone_number
	end

	# def receive_options
	# 	twilio_client.account.list.each do |message|
 #    	puts message.inspect
 #    	user = where(phone_number: params[:From])
    	
 #    end
	# end

	def doggies
		send_message("Welcome to Catupult! Do you like dogs or cats? Text dogs to see dogs, or cats to see cats.")
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
			user.uid        = auth['uid']
			user.token      = auth['credentials']['token']
			user.first_name = auth['info']['first_name']
			user.last_name  = auth['info']['last_name']
		end
	end
end
