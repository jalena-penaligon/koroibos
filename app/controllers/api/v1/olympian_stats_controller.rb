class Api::V1::OlympianStatsController < ApplicationController
  def show
    render json: {
      olympian_stats: Olympian.get_stats
    }
  end
end
