class PublicController < ApplicationController
  def home
  	if current_user 
  		current_user.client
  	end
  end
end
