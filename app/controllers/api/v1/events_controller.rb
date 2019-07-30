class Api::V1::EventsController < ApplicationController
  def index
    render json: {
      events: Sport.all.as_json
    }
  end
end
