class SessionsController < ApplicationController
  title "Login";
  
  def create
    @user = User.authenticate(params[:email], params[:password]);
    if @user
      login_user(@user);
      flash[:notice] = "Login efetuado com sucesso!";
      handle_redirection;
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
  
  protected
  def handle_redirection
    if session.key?(:redirect_path)
      path = session.delete(:redirect_path);
      flash[:info] = "Deseja ir para <a href=\"#{path}\">#{path}</a>?".html_safe unless path == page_url(:dashboard);
    end
  end  
  
end
