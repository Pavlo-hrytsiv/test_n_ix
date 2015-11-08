class ReportsController < ApplicationController
  def index
    all_urls_by_user = Url.user_urls(session[:authentication_token]).all
    @result = PriceCalculator.new.calculation_result(all_urls_by_user)
  end

  def per_day
    if params[:date]
      @date = params[:date].to_date
      all_urls_per_day = Url.user_urls(session[:authentication_token]).date(@date).all
      @result = PriceCalculator.new.calculation_result(all_urls_per_day)[0]
    end
  end
end
