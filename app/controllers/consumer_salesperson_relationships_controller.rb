class ConsumerSalespersonRelationshipsController < ApplicationController
  requires_authentication
  #before_filter :check_data, only: [:create];
  
  
  def new
    @relationship = ConsumerSalespersonRelationship.new;
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
  
  def update
    @relationship = ConsumerSalespersonRelationship.find(params[:id]);
    if @relationship.update_attributes(params[:consumer_salesperson_relationship])
      flash[:notice] = "Dados atualizados com sucesso!";
    else
      flash[:error] = "Erro ao atualizar dados."
    end
    redirect_to :back;
  end
  
  def destroy
    @relationship = ConsumerSalespersonRelationship.find(params[:id]);
    @relationship.destroy;
    flash[:info] = "#{@relationship.target.name} removido(a) da sua rede.";
    redirect_to :back;
  end
  
  protected
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
