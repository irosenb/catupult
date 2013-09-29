class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def sleep
  	puts params.inspect
  	events_hash = JSON.parse(params["events"])
    user = User.find(uid: events_hash['user_xid'])
  	events_hash["events"].each do |event|
  		if event["event_type"] == "mood" and event["action"] == "creation"
  			sleep_event = event["event_xid"]
  		end
  	end
    user.get_mood
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
