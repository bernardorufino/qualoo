class ConsumersController < ApplicationController
  
  def index  
    @users = Consumer.all;
    title friendly_profile_name(:consumer, plural: true), :freeze => true;
    render "users/index";
  end
  
  def show
    @consumer = Consumer.find(params[:id]);
  end
  
end
