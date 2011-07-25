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
  
  def destroy
    @m = Message.find params[:id]
    @m.destroy
    
    redirect_to "/messages"
  end
  
  def create
    @m = Message.new params[:message]
    u = User.find :all, :conditions => {:nick => @m.to_name}
    unless u.first.nil?
      @m.to_id = u.first.id
      @m.from_id = current_user.id
    
      if @m.save
        redirect_to "/messages"
      else
        render action: "new"
      end
    else
      render action: "new"#/#{@m.id}"
    end
  end
  
  def edit
    @m1 = Message.find params[:id]
    @m = Message.new :to_name => (User.find @m1.from_id).nick, :body => @m1.body, :betreff => "Re: #{@m1.betreff}"
  end

end
