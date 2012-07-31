class GrouponDealController < ApplicationController
  before_filter :facebook_authorizer

  def show
    @groupon = GrouponDeal.find(params[:id])
    @title = @groupon[:merchant_name]
    @page_url = SITE_URL + "/groupon_deal/#{params[:id]}?static_page=true"

    if (params[:view])
      viewdeal
    elsif (params[:buy] && params[:option])
      buydeal
    elsif (params[:static_page])
      #do nothing
    else
      respond_to do |format|
        format.html
        format.js { render :layout => false}
      end
    end
  end

  def search
    @title = params[:search]
    @page_url = SITE_URL + "/search?search=" + params[:search] 

    if @title.empty?
      flash[:error] = 'Invalid search'
      redirect_to :back
    else
      @groupon_deal = GrouponDeal.find_with_index('^'+params[:search])
      @groupon_deal = @groupon_deal.select {|x| x[:active_status]} | @groupon_deal.reject {|x| x[:active_status]}
      @groupon_deal = @groupon_deal.paginate(:page => params[:page], :per_page => 10)
      
      if @groupon_deal.empty?
        flash[:error] = "Your search - #{params[:search]} - did not match any deals"
        redirect_to :back
      else
        respond_to do |format|
          format.html
          format.js { render :layout => false}
        end
      end
    end

  end

  def viewdeal
    @groupon = GrouponDeal.find(params[:id])    
    @page_url = SITE_URL + "/groupon_deal/" + params[:id] + "?static_page=true"
    if (!session.nil?) 
      Thread.new { @viewed_action = session[:api].put_connections("me", "faiceupon:view", :groupon => @page_url) }
    end
    redirect_to @groupon.dealUrl
  end

  def buydeal
    @groupon = GrouponDeal.find(params[:id])
    @option = DealOption.find(params[:option])
    @page_url = SITE_URL + "/groupon_deal/" + params[:id] + "static_page=true"
    if (!session.nil?) 
      Thread.new { session[:api].put_connections("me", "faiceupon:buy", :groupon => @page_url) }
    end
    redirect_to @option.buyUrl
  end



end


