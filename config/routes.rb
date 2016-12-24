Rails.application.routes.draw do
  root :to => redirect('/links')

  resources :links, only: [:index, :create, :show]
end
