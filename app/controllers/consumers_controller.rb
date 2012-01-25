class ConsumersController < ApplicationController
  requires_authentication only: :manage;
  before_filter :check_manage, only: [:index];
  
  def search
    @users = Consumer.search(params[:query]);
    title "Pesquisa de #{friendly_profile_name(:consumer, plural: true).downcase} por \"#{params[:query]}\"", :freeze => true;
    render "users/index";
  end
  
  def manage
    @relationships = current_profile.relationships;
  end 
  
  def index  
    @users = Consumer.all;
    title friendly_profile_name(:consumer, plural: true), :freeze => true;
    render "users/index";
  end
  
  def show
    @consumer = Consumer.find(params[:id]);
  end
  
  def new
    welcome_user;
  end
  
  protected
  def check_manage
    if params[:salesperson_id]
      manage;
      render :action => :manage;
      false;
    else true; end
  end
    
  
end
