class PagesController < ApplicationController
  requires_authentication only: :dashboard;



end