class ReviewsController < ApplicationController

	before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index

  	@event = Event.find_by_id(params[:event_id])
  	render json: @event.reviews
  end

	def create

		new_review = params.require(:review).permit(:body, :cool, :ratio, :grime, :event_id)
		review = Review.create(new_review)
		event = Event.find_by_id(params[:event_id])

		event.reviews << review

		render json: review
	end

	def show
		raise params.inspect
		event_id = params.require(:review)

		respond_with Review.find_by_event_id(event_id)
	end


	private

  def render_main_layout_if_format_html
  # check the request format
    if request.format.symbol == :html
    render "layouts/application"
    end
  end

end
