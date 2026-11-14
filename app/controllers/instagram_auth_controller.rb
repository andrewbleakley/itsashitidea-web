# app/controllers/instagram_auth_controller.rb
class InstagramAuthController < ApplicationController
  def callback
    return redirect_to root_path, alert: "Login cancelled" if params[:error]
    # verify params[:state] matches the one you stored in session
    # exchange params[:code] for a token at graph.facebook.com
  end
end
