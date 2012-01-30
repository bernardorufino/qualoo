module SalespeopleHelper
  
  # Assuming a salesperson with rank 0 has no ranking available, avoiding future problems
  def rank_available?(salesperson)
    l = salesperson.rank_level;
    l and l != 0;
  end
  
  def salesperson_form_url
    {
      new_salesperson_path => salespeople_path,
      edit_salesperson_path(params[:id]) => salesperson_path(current_profile)
    }[request.path];
  end
  
  def salesperson_form_method
    {
      new_salesperson_path => :post,
      edit_salesperson_path(params[:id]) => :put
    }[request.path];    
  end
  
end
