class PagesController < ApplicationController

  def callback
    @title = "Callback"
    @page_url = SITE_URL + "/pages/callback" 
    
    redirect_to SITE_URL
  end

  def home
    @title = "Home"
    @page_url = SITE_URL + "/"

    #@groupon = GrouponDeal.find(2)

    if (params[:code])
      
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      @api = Koala::Facebook::API.new(session[:access_token]) 
      #@graph_data = @api.get_object("/me/statuses")
      #@api.put_connections("me", "faiceupon:buy", :groupon => @page_url)
      session[:api] = @api
    else
      session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, @page_url)
      @auth_url = session[:oauth].url_for_oauth_code(:permissions=>"user_about_me, user_likes, friends_likes, publish_actions, publish_stream, share_item")    
    end

    render :layout => false
  end

  def facebook_action
  end

end
