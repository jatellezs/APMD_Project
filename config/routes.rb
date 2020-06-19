Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'
  get '/rating_runtime', to: 'main#runtime'
  get '/workers', to: 'main#actors'
  get '/heatmap', to: 'main#heatmap'
  get '/titleRating', to: 'main#titleRating'
end
