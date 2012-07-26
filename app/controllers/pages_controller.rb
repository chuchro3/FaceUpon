class PagesController < ApplicationController
  before_filter :facebook_authorizer

  def callback
    @title = "Callback"

    redirect_to SITE_URL
  end

  def home
    @title = "Home"
    @page_url = SITE_URL + "/"

    render :layout => false
  end

end
