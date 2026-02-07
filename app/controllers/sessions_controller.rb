class SessionsController < ApplicationController
  def learn
    auth = request.env["omniauth.auth"]

    if auth.blank?
      redirect_to root_path, alert: "Missing OAuth payload."
      return
    end

    info = auth.fetch("info", {})
    session[:learn_uid] = auth["uid"]
    session[:learn_user] = info.slice("email", "name", "first_name", "last_name", "image")
    session[:learn_token] = auth.dig("credentials", "token")

    redirect_to root_path, notice: "Signed in with LEARN."
  end

  def failure
    message = params[:message].presence || "Authentication failed."
    redirect_to root_path, alert: message
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out."
  end
end
