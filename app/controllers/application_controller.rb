class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sleep
  	puts params.inspect
  	events_hash = JSON.parse(params[:events])
  	events_hash["events"].each do |event|
  		sleep_event = event["event_xid"] if event["event_type"] = "sleep"
  	end
    current_user.get_sleep(id)
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
