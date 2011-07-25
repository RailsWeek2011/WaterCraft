class ProfileController < ApplicationController
	before_filter :authenticate_user!
	
  def show
  	@profil = User.find params[:id]
  	@anz = @profil.win + @profil.lose
  end

  def edit
  end
  
  def create
    	@f = Fish.new :race => params[:id]

		if @f.save
			u = User.find current_user.id
			u.fish_id = @f.id
			u.save
		    redirect_to "/profile/show/#{current_user.id}"
		else
		    render "/profile/new"
		end
  end
  
  def new
  	dirname = "app/assets/images/Fisch"
  	dir = Dir.new(dirname)
  	@entries = []
  	while entry = dir.read
  		path = "#{dirname}/#{entry}"
  		if File.file?(path)
  			@entries.push "Fisch/#{entry}"
  		end
  	end
  	
  end

  def index
  	@u = User.all
  end

end
