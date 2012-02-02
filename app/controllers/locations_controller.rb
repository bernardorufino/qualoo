class LocationsController < ApplicationController
  requires_authentication
  
  def search
    @location = current_profile.location;
    @nearbys = @location.nearbys(params[:radius].to_i.km);
    @profiles = @nearbys.map(&:localizable);
  end
  
  def new
    @location = current_profile.build_location;
  end
  
  def create
    @location = current_profile.build_location(params[:location]);
    if @location.save
      flash[:notice] = "Endereco adicionado com sucesso!";
      redirect_to profile_path(current_profile);
    else
      flash[:error] = "Erro ao adicionar endereco.";
      render :action => :new;
    end
  end
  
  def edit
    @location = current_profile.location;
  end
  
  def update
    @location = current_profile.location;
    if @location.update_attributes(params[:location])
      flash[:notice] = "Endereco atualizado com sucesso!";
      redirect_to profile_path(current_profile);
    else
      flash[:error] = "Erro ao atualizar endereco.";
      render :action => :edit;
    end
  end
  
end
