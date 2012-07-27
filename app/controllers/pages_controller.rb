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

  def logout

    reset_session

    respond_to do |format|
      format.html { flash[:error] = 'You have been logged out.'}
    end
  end

end
