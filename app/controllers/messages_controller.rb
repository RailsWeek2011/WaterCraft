class MessagesController < ApplicationController
  
  def index
  	to = current_user.id
    @m = Message.find 
  end

  def show
    
  end

  def new
    
  end

end
