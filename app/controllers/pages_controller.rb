class PagesController < ApplicationController
  requires_authentication only: :dashboard;

  def geocode
    debug request.location;
  end

end