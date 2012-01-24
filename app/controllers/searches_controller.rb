class SearchesController < ApplicationController
  before_filter :buffer_fields, only: [:create];
  
  
  def create
    @search = Search.new(params[:search]);
    redirect_to @search.path;
  end
  
  protected
  def buffer_fields
    session[:search] = {
      query: params[:search][:query],
      location: params[:search][:location]
    };
  end
  
end
