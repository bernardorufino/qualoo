class PostsController < ApplicationController
  requires_authentication user: :salesperson;

  def create
    @post = current_profile.posts.new(params[:post]);
    if @post.save
      flash[:notice] = "Post criado com sucesso!";
      redirect_to salesperson_path(current_profile);
    else
      flash[:error] = "Post vazio!";
      redirect_to :back;
    end
  end
  
  def destroy
    @post = current_profile.posts.find(params[:id]);
    @post.destroy;
    flash[:info] = "Post deletado.";
    redirect_to salesperson_path(current_profile);
  end

end