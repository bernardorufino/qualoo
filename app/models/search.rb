class Search
  extend GlobalHelper;
  include GlobalHelper;
  attr_accessor :query, :location;
  
  def self.locations
    {
      friendly_profile_name(:consumer, plural: true) => "consumers",
      friendly_profile_name(:salesperson, plural: true) => "salespeople",
      "Usuarios" => "users",
      "Marcas" => "companies",
      "Generos" => "categories"      
    };
  end
  
  def initialize(params)
    @query = params[:query];
    @location = params[:location];
  end
  
  def path(opts={}, *args)
    Rails.application.routes.url_helpers.send("search_#{@location}_path", {query: @query}.merge(opts), *args);
  end
  
end