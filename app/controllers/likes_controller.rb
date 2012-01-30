class LikesController < ApplicationController
  requires_authentication;
  
  def create
    @post = Post.find(params[:post_id]);
    @post.like(current_user);
    redirect_to :back;    
  end
  
  def destroy
    @post = Post.find(params[:post_id]);
    @post.unlike(current_user);
    redirect_to :back;    
  end
  
end
