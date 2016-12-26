Rails.application.routes.draw do
  root to: 'links#index'

  post '/', to: 'links#create'
  get '/:shorten', to: 'links#show'
end
