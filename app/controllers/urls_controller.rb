class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  def my
    @urls = Url.user_urls(session[:authentication_token]).all
  end

  def redirect
    @url = Url.where(short_url: params[:short_url], active: true).first
    if @url
      @url.active = false
      @url.save
      redirect_to @url.full_url
    else
      redirect_to urls_path, error: t(:url_not_found)
    end
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.create_url(url_params[:full_url], session[:authentication_token])
    respond_to do |format|
      if @url.valid?
        update_daily_summary
        format.html { redirect_to my_path, notice: t(:url_create) }
        format.json { render :index, status: :created, location: urls_path }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end

  end

  private
  def url_params
    params.require(:url).permit(:full_url)
  end
  def update_daily_summary
    session[:count] = Url.user_urls(session[:authentication_token]).date(Date.current).all.count
    session[:price] = PriceCalculator.new.calculate_price(session[:count])
  end
end
