class SessionsController < ApplicationController

	before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def new
  end

  def create
    @user = User.authenticate(params[:user][:username], params[:user][:password])

    if @user
      session[:user_id] = @user.id
      respond_to do |format|
        format.json {render :json => @user, :only => [:username]}
      end
    else
      render json: {}, status: 400
    end
  end

  def destroy
  session[:user_id] = nil
    respond_with nil
  end

  def logged_in_user
    if session[:user_id]
      render json: User.find_by_id(session[:user_id]), only: [:username]
    end
  end

	def render_main_layout_if_format_html
	  # check the request format
	if request.format.symbol == :html
	render "layouts/application"
	end
	end

end