class UsersController < ApplicationController  
  requires_authentication only: [:avatar, :edit, :update];
  
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
    #debug "hop"
    @user = User.new(params[:user]);
    if @user.save
      login_user(@user);
      redirect_to send("new_#{to_profile_sym(@user)}_path");
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
    if @user.update_attributes!(params[:user])
      flash[:notice] = "Dados atualizados com sucesso!";
      redirect_to :back;
    else
      flash.now[:error] = "Erro ao atualizar dados. Atente para os campos destacados abaixo.";
      render :action => :edit;
    end
  end
  
end
