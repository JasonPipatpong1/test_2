class Moviegoer < ActiveRecord::Base
  has_many :reviews
  has_many :reviews, :through => :reviews
  def self.create_with_omniauth(auth)
    Moviegoer.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"])
  end
end
