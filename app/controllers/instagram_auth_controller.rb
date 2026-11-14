# app/controllers/instagram_auth_controller.rb
class InstagramAuthController < ApplicationController
  def callback
    return redirect_to root_path, alert: "Login cancelled" if params[:error]
    # verify params[:state] matches the one you stored in session
    # exchange params[:code] for a token at graph.facebook.com
  end
end

## https://www.facebook.com/dialog/oauth?client_id=985601670810925&config_id=4573507356271370&display=popup&override_default_response_type=true&redirect_uri=https%3A%2F%2Fitsashitidea.com%2Fauth%2Finstagram%2Fcallback&response_type=code&state=%3CSTATE%3E&prompt=login

## EAAOAZAkV6jS0BS9LK6098XIQAV7HlQRLAffgkGmgX7QDEinKQkr9q5HZBsNuK2bFRgTty6jZCSnfdbPAPOlRyh5vhitNZAND3bfUxO5kmZAsRSwYY4q5RmCdfVJAedeoOTom745gKbERc8Dcm00Y0QAGGmwympwrk0ZAZAZCOXayZAGLZAC7ANsJgZCuUtS4ay24fYZC24ZB1lBnJRvwmqvl56PZAFZAApMRztUVoANLuSdqeU4AsLcFVjOegZDZD
