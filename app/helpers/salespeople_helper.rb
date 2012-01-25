module SalespeopleHelper
  
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
