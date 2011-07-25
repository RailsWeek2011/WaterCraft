class MessagesController < ApplicationController

	before_filter :authenticate_user!
	
  def index
  	@m = Message.find  :all, :conditions => {:to_id => current_user.id}
  end

  def show
    @m = Message.find params[:id]
  end

  def new
  	@m = Message.new
  end
  
  def delete
    @m = Message.find params[:id]
    @m.destroy
    
    redirect_to "/messages/index"
  end
  
  def create
    @m = Message.new params[:m]
    u = User.find :all, :conditions => {:nick => @m.to_name}
    unless u.first.nil?
      @m.to_id = u.first.id
      @m.from_id = current_user.id
    
      if @m.save
        redirect_to "/messages/index"
      else
        render action: "new"
      end
    else
      render action: "new"#/#{@m.id}"
    end
  end

end
