class GuestsController < ApplicationController
  layout "promo";
  
  def create
    @guest = Guest.new(params[:guest]);
    if @guest.save
      redirect_to page_path(:thanks);
    else
      redirect_to :back;
    end
  end
  
  
end
