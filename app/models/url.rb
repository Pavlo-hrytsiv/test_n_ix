require 'securerandom'

class Url < ActiveRecord::Base
  validates :full_url, :url => true
  scope :user_urls, -> (authentication_token){ where(authentication_token: authentication_token) }
  scope :date, -> (created_at){ where(created_at: created_at..created_at+1) }
  def self.create_url(full_url, authentication_token)
    url = Url.new
    url.active = true
    url.full_url = full_url
    url.authentication_token = authentication_token
    url.short_url = SecureRandom.urlsafe_base64(7)
    url.valid? ? ensure_save(url) : url
  end

  def self.ensure_save(url)
    url.save!
    url
  rescue ActiveRecord::RecordNotUnique
    url.short_url = SecureRandom.urlsafe_base64(7)
    ensure_save(url)
  end
end
