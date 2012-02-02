 class ConsumerSalespersonRelationshipsController < ApplicationController
  requires_authentication
  #before_filter :check_data, only: [:create];
  
  def index
    @tag = current_user.tags.find(params[:tag_id]);
    @relationships = @tag.relationships;
  end
  
  def new
    @relationship = current_profile.relationships.new;
    @user = to_profile(current_profile.relates_with).find(params[:id]);
    @consumer = pick_consumer(current_user, @user);
    @salesperson = pick_salesperson(current_user, @user);
  end
  
  def create
    # Check the owner as the current_user
    @relationship = current_profile.relationships.new(params[:consumer_salesperson_relationship]);
    if @relationship.save
      flash[:notice] = "#{@relationship.target.name} foi adicionado a sua rede!";
      redirect_to profile_path(@relationship.target);
    else
      flash[:error] = "Erro ao tentar adiciona-lo a sua rede";
      redirect_to params[:target_path];
    end
  end
  
  def update
    # Check the owner as the current_user
    @relationship = current_profile.relationships.find(params[:id]);
    if @relationship.update_attributes(params[:consumer_salesperson_relationship])
      flash[:notice] = "Dados atualizados com sucesso!";
    else
      flash[:error] = "Erro ao atualizar dados."
    end
    redirect_to :back;
  end
  
  def destroy
    # Check the owner as the current_user
    @relationship = current_profile.relationships.find(params[:id]);
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
