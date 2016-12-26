Rails.application.routes.draw do
  root to: 'links#index'
  
  resources :links, only: %i[create show]
end
