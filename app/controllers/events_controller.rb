class EventsController < ApplicationController

  before_action :is_authenticated?, only: [:create]
  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
    respond_with Event.all.to_json :include => :user
  end

  def create
    hashtag = params.require(:event).permit(:hashtag)
    results = twitter_call hashtag[:hashtag]
    tweet_count = results.to_a.length

    new_event = params.require(:event).permit(:name, :hashtag, :desc, :loc, :date)
    new_event[:tweet_count] = tweet_count
    new_event[:user_id] = @current_user.id

    respond_with Event.create(new_event)

  end

  def update
    new_info = params.require(:event).permit(:name, :hashtag, :desc, :loc)
    @event = Event.find_by_id(params[:id])

    @event.update_attributes(
      :name    => new_info[:name],
      :hashtag => new_info[:hashtag],
      :desc    => new_info[:desc],
      :loc     => new_info[:loc])

    render json: @event

  end

  def destroy
    event = Event.find_by_id(params[:id])
    respond_with event
    event.destroy()
  end

  private

  def render_main_layout_if_format_html
  # check the request format
    if request.format.symbol == :html
    render "layouts/application"
    end
  end
end
