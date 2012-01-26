class Search
  extend GlobalHelper;
  include GlobalHelper;
  attr_accessor :query, :scope, :params;
  
  def initialize(params)
    @params = params.clone;
    @query = @params.delete(:query);
    @scope = @params.delete(:scope);
  end
  
  def route(opts={}, *args)
    Rails.application.routes.url_helpers.send("search_#{@scope}_path", {query: @query}.merge(@params).merge(opts), *args);
  end
  
  def method_missing(method, *args, &block)
    return @params[method] if @params.key?(method)
    super(method, *args, &block);
  end
  
end