class SalespeopleController < ApplicationController
  before_filter :check_manage, only: [:index];
   
  def search
    @users = Salesperson.search(params[:query]);
    title "Pesquisa de #{friendly_profile_name(:salesperson, plural: true).downcase} por \"#{params[:query]}\"", :freeze => true;
    render "users/index";
  end
   
  def manage
    @relationships = current_profile.relationships;
  end 
   
  def index
    @users = Salesperson.all;
    title friendly_profile_name(:salesperson, plural: true), :freeze => true;
    render "users/index";
  end
  
  def show
    @salesperson = Salesperson.find(params[:id]);
  end
  
  protected
  def check_manage
    if params[:consumer_id]
      manage;
      render :action => :manage;
      false;
    else true; end
  end
  
end
