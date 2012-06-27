class PagesController < ApplicationController


  def callback
    @title = "Callback"
    @page_url = SITE_URL + "/pages/callback" 


    if (params[:code])
      print "hi"
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      @api = Koala::Facebook::API.new(session[:access_token]) 
      @graph_data = @api.get_object("/me/statuses")
      @api.put_connections("me", "faiceupon:buy", :groupon => @page_url+"?code="+params[:code])
    

    end

  end

  def home
    @title = "home"
    @page_url = SITE_URL

    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL+'/pages/callback')
    @auth_url = session[:oauth].url_for_oauth_code(:permissions=>"read_stream")    
  end

  def facebook_action
  end

end
