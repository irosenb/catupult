class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sleep
  	puts params.inspect
  	events_hash = JSON.parse(params[:events])
  	events_hash["events"].each do |event|
  		if event["event_type"] == "sleep" and event["action"] == "creation" 
  			sleep_event = event["event_xid"]
  		end
  	end
    current_user.get_sleep(sleep_event)
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
