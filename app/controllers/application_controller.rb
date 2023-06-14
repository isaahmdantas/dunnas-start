class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  protect_from_forgery prepend: true, with: :null_session, if: proc { |c| c.request.format == 'application/json' }
end

