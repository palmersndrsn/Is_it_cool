class EventsController < ApplicationController

  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
    respond_with Event.all
  end

  def create
    hashtag = params.require(:event).permit(:hashtag)
    new_event = params.require(:event).permit(:name, :hashtag, :desc, :loc)
    respond_with Event.create(new_event)

  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def render_main_layout_if_format_html
  # check the request format
    if request.format.symbol == :html
    render "layouts/application"
    end
  end
end
