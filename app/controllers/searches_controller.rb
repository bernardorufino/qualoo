class SearchesController < ApplicationController
  before_filter :buffer_fields, only: [:create];
  
  
  def create
    @search = Search.new(params[:search]);
    redirect_to @search.route;
  end
  
  protected
  def buffer_fields
    session[:search] = params[:search];
  end
  
end
