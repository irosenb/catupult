class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def sleep
  	puts params.inspect
  	events_array = params["events"]
    user = User.find_by_uid(events_array.first['user_xid'])
    is_mood = false
  	events_array.each do |event|
  		if event["type"] == "mood" and event["action"] == "creation"
        is_mood = true
  		end
  	end
    user.get_mood if is_mood
    render :nothing => true
  end

  def sms
    puts params.inspect
    from = params["From"]
    @user = User.find_by_phone_number(from)
    @user.message("hello there")
    render :nothing => true   
    # render :sms 
    # @user.sms
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
