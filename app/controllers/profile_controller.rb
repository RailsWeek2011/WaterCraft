class ProfileController < ApplicationController
	
  def show
  	@profil = User.find params[:id]
  	@anz = @profil.win + @profil.lose
  end

  def edit
  end
  
  def create
  		current_user.fish_id = nil
  		current_user.save
  		
  		@f = Fish.all
  		@f.each do |s|
  			@u = User.where :fish_id => s.id
  			if @u.first.nil?
  				s.destroy
  			end
  		end
  		
  		@stat = getRaceStat params[:race].to_i
  		if params[:nick] == ""
  			params[:nick] = "Anonymous"
  		end
    	@f = Fish.new :race => params[:race], :name => params[:nick], :str => @stat[:str], :dex => @stat[:dex], :con => @stat[:con], :init => @stat[:init], :dev => @stat[:dev]

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
