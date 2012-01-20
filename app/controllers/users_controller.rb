class UsersController < ApplicationController  
  
  def by_profile
    if User.profile_type?(params[:profile])
      @users = User.find_by_profile(params[:profile]);
      title friendly_profile_name(params[:profile], plural: true), :freeze => true;
      render :action => :index;
    else
      flash[:alert] = "Voce nao esta autorizado a realizar tal operacao."
      redirect_to root_path;
    end
  end
  
  def index
    @users = User.all;
  end
  
  def show
    @user = User.find(params[:id]);
  end
  
  def new
    @user = User.new;
  end
  
  def create
    @user = User.new(params[:user]);
    if @user.save
      flash[:notice] = "Bem vindo, #{@user.name}!";
      login_user(@user);
      redirect_to page_path(:dashboard);
    else
      flash.now[:error] = "Erro ao criar usuario. Atente para os campos destacados abaixo.";
      render :action => :new;
    end
  end
  
  def edit
    @user = User.find(params[:id]);
  end
  
  def update
    @user = User.find(params[:id]);
    if @user.update_attributes(params[:user])
      flash[:notice] = "Dados atualizados com sucesso!";
      redirect_to edit_user_path(@user)
    else
      flash.now[:error] = "Erro ao atualizar dados. Atente para os campos destacados abaixo.";
      render :action => :new;
    end
  end
  
end
