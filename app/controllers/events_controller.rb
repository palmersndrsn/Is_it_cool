class EventsController < ApplicationController

  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
    respond_with Event.all
  end

  def create # need to add dates and geo location

    hashtag = params.require(:event).permit(:hashtag)
    results = twitter_call hashtag[:hashtag]
    tweet_count = results.to_a.length

    loc = params.require(:event).permit(:loc)
    geo = Geocoder.coordinates(loc)

    new_event = params.require(:event).permit(:name, :hashtag, :desc, :loc, :date)
    new_event[:tweet_count] = tweet_count
    new_event[:lat]  = geo[0]
    new_event[:long] = geo[1]

    respond_with Event.create(new_event)


  end

  def update
    new_info = params.require(:event).permit(:name, :hashtag, :desc, :loc)
    @event = Event.find_by_id(params[:id])
    p "route works"

    p new_info

    @event.update_attributes(
      :name    => new_info[:name],
      :hashtag => new_info[:hashtag],
      :desc    => new_info[:desc],
      :loc     => new_info[:loc])

    render json: @event

  end

  def destroy
    event = Event.find_by_id(params[:id])
    p "SHOULD BE THE EVENT"
    p event
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
