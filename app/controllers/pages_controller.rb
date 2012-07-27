class PagesController < ApplicationController
  before_filter :facebook_authorizer

  def callback
    @title = "Callback"

    redirect_to SITE_URL
  end

  def home
    @title = "Home"
    @page_url = SITE_URL + "/"

    @quote = Quote.all[rand(Quote.count)]

    render :layout => false    
  end

  def logout

    reset_session
    facebook_authorizer

    respond_to do |format|
      format.html { flash[:error] = 'You have been logged out.'}
      format.js { render :layout => false }
    end
  end
end
