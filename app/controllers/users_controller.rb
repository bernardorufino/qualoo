class UsersController < ApplicationController  
  requires_authentication only: [:edit, :update];
  
  def search
    @users = User.search(params[:query]);
    title "Pesquisa de usuarios por \"#{params[:query]}\"", :freeze => true;
    render "index";
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
    @user = current_user;
  end
  
  def update
    @user = current_user;
    if @user.update_attributes(params[:user])
      flash[:notice] = "Dados atualizados com sucesso!";
      redirect_to edit_user_path(@user)
    else
      flash.now[:error] = "Erro ao atualizar dados. Atente para os campos destacados abaixo.";
      render :action => :new;
    end
  end
  
end
