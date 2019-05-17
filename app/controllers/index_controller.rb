class IndexController < ActionController::Base
  def index
    render plain: 'welcome'
  end
end
