class UsersController < ApplicationController

  before_action :user_params, only: [:show, :update, :destroy]

  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
  end

  def create
    up = params.require(:user).permit(:email, :username, :password)
    respond_with User.create(up)
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def render_main_layout_if_format_html
  # check the request format
    if request.format.symbol == :html
    render "layouts/application"
    end
  end
end
