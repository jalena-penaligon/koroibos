class Api::V1::OlympiansController < ApplicationController
  def index
    if params["age"] == nil
      olympians = Olympian.all
      render json: {
      olympians: olympians.as_json
      }
    else
      olympian = Olympian.by_age(params["age"])
      render json: olympian
    end
  end
end
