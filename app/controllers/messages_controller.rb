class MessagesController < ApplicationController
	before_filter :authenticate_user!
	
  def index
  	@m = Message.find  :all, :conditions => {:to_id => current_user.id}
  end

  def show
  end

  def new
  end

end
