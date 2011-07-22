class ProfileController < ApplicationController
	before_filter :authenticate_user!
	
  def show
  	@profil = User.find params[:id]
  end

  def edit
  end

  def index
  	@u = User.all
  end

end
