class User < ActiveRecord::Base
  devise :registerable, :database_authenticatable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  
  acts_as_favorite_user

  has_many :comments
  has_many :likes
  has_many :favorites
  
  def display_name
    name.present? ? name : "User ##{self.id}"
  end
  
end


# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  name                 :string(255)     default(""), not null
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  admin                :boolean         default(FALSE)
#

