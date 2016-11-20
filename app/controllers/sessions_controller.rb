class SessionsController < ApplicationController

  skip_before_action :check_login

  def new
    #first sign out....
    session['user_email'] = "" #assigning to nil didn't work...
    #Allow us to login to the test & dev environments simply by passing an email.
    if ((Rails.env.test? || Rails.env.development?) && params['email'].present?)
      session['user_email'] = user.email
      flash['notice'] = "Successfully signed in as " + user.name.to_s
      #redirect to "/" unless we have a previous url
      redirect_to_previous_url
      return
    else
      #for some reason, I couldn't just call my check_login function...
      #if not logged in, redirect to google auth
      redirect_to '/auth/google_oauth2'
      return
    end
  end

  def create
    if(env["omniauth.auth"].info['email'].match(/digital.cabinet-office\.gov\.uk$/))
      session['user_email'] = env["omniauth.auth"].info['email']
      flash['notice'] = "Successfully signed in."
    else
      flash['error'] = "Sorry, you must have a GDS or Cabinet Office email address to login."
    end
    #byebug
    redirect_to_previous_url
  end

  def handle_failure
    flash['error'] = "Sorry, the authentication service returned the following error: " + params['message']
    session['user_email'] = nil
    redirect_to_previous_url
  end

  def destroy
    session['user_email'] = "" #assigning to nil didn't work...
    flash['notice'] = "Successfully signed out."
    redirect_to "/"
  end

  private

  def redirect_to_previous_url
    redirect_to session[:previous_url].nil? ? "/" : session[:previous_url]
  end

end
