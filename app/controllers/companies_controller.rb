class CompaniesController < ApplicationController  
  
  def search
    @companies = Company.search(params[:query]);
    title "Pesquisa de marcas por \"#{params[:query]}\"", :freeze => true;
    render "index";
  end
  
  def index
    @companies = Company.all;
  end
  
  def show
    @company = Company.find(params[:id]);
  end
  
end
