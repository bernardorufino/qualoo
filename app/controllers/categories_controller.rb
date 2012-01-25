class CategoriesController < ApplicationController
  
  def search
    @categories = Category.search(params[:query]);
    title "Pesquisa de generos por \"#{params[:query]}\"", :freeze => true;
    render "index";
  end
  
  def index
    @categories = Category.all;
  end
  
  def show
    @category = Category.find(params[:id]);
  end
  
end
