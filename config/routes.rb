Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/olympians', to: 'olympians#index'
      get '/olympian_stats', to: 'olympian_stats#show'
      get '/events', to: 'events#index'
      get '/events/:id/medalists', to: 'events/medalists#show'
      get '/most_winning_team', to: 'most_winning#show'
      get '/most_losing_team', to: 'most_losing#show'
    end
  end
end
