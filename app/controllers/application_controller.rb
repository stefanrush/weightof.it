class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected
  
  def render_404
    render template: 'errors/not_found', status: :not_found
    return
  end
end
