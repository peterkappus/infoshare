class SessionsController < ApplicationController

  skip_before_action :check_login

  def new
    #first sign out....
    session['user_email'] = "" #assigning to nil didn't work...
    # !!!HEADS UP!!!
    # Allow us to login to the test & dev environments simply by passing an email.
    if ((Rails.env.test? || Rails.env.development?) && params['email'].present?)
      if(user = User.find_by_email(params['email']))
        session['user_email'] = user.email
        flash['notice'] = "Successfully signed in as " + user.name.to_s
      else
        flash['error'] = "Sorry, could not find an account with the email " + params['email'].to_s + " please speak with an administrator to request an account."
      end
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
    email = env["omniauth.auth"].info['email']
    #if(env["omniauth.auth"].info['email'].match(/digital.cabinet-office\.gov\.uk$/))
      #Admin MUST create the user... so we just do a lookup
      #user = User.find_or_create_by(:email=>env["omniauth.auth"].info['email'])
      #user.name = env["omniauth.auth"].info['name']
    if(user = User.find_by(email: email))
      #!!!Make the very first user into an admin AND EVERY user in the sandbox environment
      #if this is the first user, or we're in a sandbox environment.
      if User.all.empty? || env["IS_SANDBOX"]
        user.admin = true
      end
      #user.email = env["omniauth.auth"].info['email']
      user.save!
      session['user_email'] = user.email
      flash['notice'] = "Successfully signed in as " + user.name
    else
      flash['error'] = "Sorry, could not find an account for the email #{email}."
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
