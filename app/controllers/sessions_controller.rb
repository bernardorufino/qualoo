class SessionsController < ApplicationController
  title "Login";
  
  def create
    @user = User.authenticate(params[:email], params[:password]);
    if @user
      login_user(@user);
      flash[:notice] = "Login efetuado com sucesso!";
      redirect_to page_path(:dashboard);
    else
      flash.now[:error] = "Email ou senha incorretos. Tente novamente";
      render :action => :new;
    end
  end
  
  def destroy
    logout_user;
    flash[:info] = "Logout efetuado.";
    redirect_to root_path;
  end
  
end
