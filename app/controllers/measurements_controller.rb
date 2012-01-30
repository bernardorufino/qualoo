class MeasurementsController < ApplicationController
  requires_authentication;
  
  def create
    @salesperson = Salesperson.find(params[:salesperson_id]);
    @measurement =  @salesperson.rank(params[:level].to_i, current_user)
    flash[:alert] = "Nao e permitido se auto-avaliar" unless @measurement;
    redirect_to :back;    
  end
  
end
