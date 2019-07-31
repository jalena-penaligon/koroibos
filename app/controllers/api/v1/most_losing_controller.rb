class Api::V1::MostLosingController < ApplicationController
  def show
    least_wins = Olympian.most_losing_team[0]
    render json: {
      most_losing_team: least_wins.team,
      total_medals_not_won: least_wins.count
    }
  end
end
