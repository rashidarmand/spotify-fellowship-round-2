class HomeController < ApplicationController
  before_action :authenticate, :except => [:index, :sign_in]

  def index
  end

  def sign_in
    if params[:username] == 'username' && params[:password] == 'password'
      session[:login] = true
      flash[:success] = 'You Successfully Logged In !'
      redirect_to action: 'calendar'
    elsif params[:username] != 'username' && params[:password] != 'password'
      flash[:warning] = 'Incorrect Username or Password !'
      redirect_to action: 'index'
    end
  end

  def sign_out
    logout
  end

  def calendar
    # Make today dynamic so we can switch months in the view
    @today = params[:date] ? Date.parse(params[:date]) : Date.today
    # First day is the first Sunday that includes the beginning of the month
    first_day = @today.beginning_of_month.beginning_of_week
    # Last day is the last Saturday that includes the end of the month
    last_day = @today.end_of_month.end_of_week
    # Weeks is an array of arrays, each of length 7, which contain full weeks i.e. Sun-Sat
    @weeks = (first_day..last_day).to_a.in_groups_of(7)
    # Events by date is all events ordered by start time
    @events_by_date = Calendar.all.order(:start_time)
    # Event is used in our form for to create a new calendar event
    @event = Calendar.new
  end


  
  private
  # Checks if user is logged in, otherwise, redirects back to the root path and prompts user to log in.
  def authenticate
    if session[:login] == true
      true
    else
      flash[:warning] = 'Please Log In !'
      redirect_to action: 'index'
    end
  end

  # Set session to nothing, logging the user out
  def logout
    session[:login] = nil
    flash[:success] = 'You successfully logged out'
    redirect_to action: 'index'
  end

end
