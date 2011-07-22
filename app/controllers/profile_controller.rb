class ProfileController < ApplicationController
	before_filter :authenticate_user!
	
  def show
  	@profil = User.find params[:id]
  	@anz = @profil.win + @profil.lose
  end

  def edit
  end
  
  def create
  
  end
  
  def new
  
  end

  def index
  	@u = User.all
  end

end
