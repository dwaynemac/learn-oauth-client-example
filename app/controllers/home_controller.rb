class HomeController < ApplicationController
  def index
    @learn_user = session[:learn_user] || {}
    @learn_uid = session[:learn_uid]
    @learn_token = session[:learn_token]
  end
end
