class User < ActiveRecord::Base
  	mount_uploader :image, ImageUploader

	has_one :fish
	#has_many :messages

	  # Include default devise modules. Others available are:
	  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
	validates :nick, :presence => true , :length => {:minimum => 3}

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me, :nick, :image
  
end
