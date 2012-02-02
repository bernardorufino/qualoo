class SalespeopleController < ApplicationController
  requires_authentication only: :manage;
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
  
  def edit
    @salesperson = current_profile;
  end
  
  def new
    flash.now[:info] = "Quase pronto! So falta preencher os dados abaixo."
    edit;
  end
  
  def create
    @salesperson = current_profile;
    if @salesperson.update_attributes(params[:salesperson])
      welcome_user;
    else
      flash[:error] = "Erro ao cadastrar #{friendly_profile_name(:salesperson).downcase}.";
      render :action => :new;
    end
  end
  
  def update
    @salesperson = current_profile;
    if @salesperson.update_attributes(params[:salesperson])
      flash[:notice] = "Dados atualizados com sucesso!";
      redirect_to page_path(:dashboard);
    else
      flash[:error] = "Erro ao atualizar dados.";
      render :action => :edit;
    end
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
