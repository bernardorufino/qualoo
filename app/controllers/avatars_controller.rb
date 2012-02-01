class AvatarsController < ApplicationController
  requires_authentication

  def edit
    @avatar = current_user.avatar;
  end
  
  def update
    @avatar = current_user.avatar;
    if @avatar.update_attributes(params[:avatar]) 
      flash[:notice] = "Imagem de perfil atualizada!";
      redirect_to user_path(current_user);
    else
      flash[:error] = "Erro ao mudar imagem de perfil.";
      render :action => :edit;
    end
  end
  
  def destroy
    current_user.default_avatar;
    flash[:info] = "Foto retirada."
    redirect_to user_path(current_user);    
  end

end