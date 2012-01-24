class TagsController < ApplicationController
  requires_authentication;
  
  def create
    @tag = current_user.tags.new(params[:tag]);
    if @tag.save
      flash[:notice] = "Tag #{@tag.name} adicionada.";
    else
      flash[:error] = "Erro ao criar tag #{@tag.name}. Talvez ela ja exista.";
    end
    redirect_to :back;
  end
  
  def destroy
    @tag = current_user.tags.find(params[:id]);
    @tag.destroy;
    flash[:info] = "Tag #{@tag.name} excluida."
    redirect_to :back;
  end
  
end
