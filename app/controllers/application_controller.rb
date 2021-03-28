class ApplicationController < ActionController::Base
  WillPaginate.per_page = 5
end
