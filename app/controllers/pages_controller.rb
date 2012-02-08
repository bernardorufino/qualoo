class PagesController < ApplicationController
  requires_authentication only: :dashboard;
  
  def presentation
    @guest = Guest.new;
    @guest.profile_type = params[:profile_type] if params[:profile_type];
    render :layout => "promo";
  end
  
  def thanks
    render :layout => "promo";
  end

end