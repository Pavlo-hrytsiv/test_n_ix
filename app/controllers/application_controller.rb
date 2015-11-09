require "digest/md5"
class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_filter :check_authorisation, :update_daily_summary

  def check_authorisation
    session[:authentication_token] ||= Digest::MD5.hexdigest(Time.now.to_s).to_s
  end
  def update_daily_summary
    session[:count] = Url.user_urls(session[:authentication_token]).date(Date.current).all.count
    session[:price] = PriceCalculator.new.calculate_price(session[:count])
  end
end
