class Api::V1::OlympiansController < ApplicationController
  def index
    olympians = Olympian.all
    render json: {
    olympians: olympians.as_json
    }
  end
end
