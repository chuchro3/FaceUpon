class ApplicationController < ActionController::Base
  protect_from_forgery

  def facebook_authorizer
    @page_url = SITE_URL + "/" 

    if (params[:code])
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      @api = Koala::Facebook::API.new(session[:access_token]) 
      session[:api] = @api
    else
      session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, @page_url)
      @auth_url = session[:oauth].url_for_oauth_code(:permissions=>"user_about_me, user_likes, friends_likes, publish_actions, publish_stream, share_item")    
    end
  end
end
