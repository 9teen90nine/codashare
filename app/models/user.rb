class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_many :comments
  has_many :snippets
  accepts_nested_attributes_for :snippets
  accepts_nested_attributes_for :comments

  def self.find_for_facebook_oauth(auth)
    where(:fb_uid => auth.uid).first_or_create do |user|
      user.fb_uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.find_for_twitter_oauth(auth)
    where(:vk_uid => auth.uid).first_or_create do |user|
      user.vk_uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end
end
