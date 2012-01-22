class ConsumerSalespersonRelationshipsController < ApplicationController
  requires_authentication
  before_filter :check_data, only: [:create];
  
  
  def new
    @user = to_profile(current_profile.relates_with).find(params[:id]);
    @consumer = pick_consumer(current_user, @user);
    @salesperson = pick_salesperson(current_user, @user);
  end
  
  def create
    @relationship = ConsumerSalespersonRelationship.new(params[:consumer_salesperson_relationship]);
    if @relationship.save
      flash[:notice] = "#{@relationship.target.name} foi adicionado a sua rede!";
      redirect_to user_path(@relationship.target);
    else
      flash[:error] = "Erro ao tentar adiciona-lo a sua rede";
      redirect_to params[:target_path];
    end
  end
  
  protected
  def check_data
    
  end
  
  def pick_target(*args)
    args.flatten.reject{|u| u.profile == current_user.profile}.first;
  end
  
  def pick_profile(profile, *args)
    args.flatten.detect{|u| u.respond_to?(:profile?) and u.profile?(profile);}.profile;
  end
  
  def pick_consumer(*args)
    pick_profile(:consumer, *args);
  end
  
  def pick_salesperson(*args)
    pick_profile(:salesperson, *args);
  end
  
end
