class User < ActiveRecord::Base
  WHITELISTED_EMAILS = /^\w.*@(gawker|deadspin|jezebel|kotaku|lifehacker|jalopnik|io9|gizmodo)\.com$/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def self.whitelisted?(email)
    !email.match(WHITELISTED_EMAILS).nil?
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data["name"],
         email: data["email"],
         avatar: data["image"],
         password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def site
    email.match(/@(\w+).com/)[1]
  end

end
