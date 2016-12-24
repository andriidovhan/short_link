Rails.application.routes.draw do
  root :to => redirect('/links')

  resources :links, only: [:index, :create]
  # do
  #   post :convert, to: 'links#convert'
  # end
end
