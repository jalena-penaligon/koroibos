class Api::V1::MostWinningController < ApplicationController
  def show
    most_wins = Olympian.most_winning_team[0]
    render json: {
      most_winning_team: most_wins.team,
      total_medals: most_wins.count
    }
  end
end
