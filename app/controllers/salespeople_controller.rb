class SalespeopleController < ApplicationController
  
  def index
    @users = Salesperson.all;
    title friendly_profile_name(:salesperson, plural: true), :freeze => true;
    render "users/index";
  end
  
  def show
    @salesperson = Salespeople.find(params[:id]);
  end
  
end
