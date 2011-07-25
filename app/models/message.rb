class Message < ActiveRecord::Base

  validates :betreff, :presence => true
  validates :body, :presence => true
  validates :to_name, :presence => true 

  has_one :user
  has_one :user

end
