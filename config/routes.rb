Rails.application.routes.draw do
  get 'nutritionists/search', action: :index, controller: :nutritionists
  get 'nutritionists/new'
  post 'nutritionists/create'

  root 'nutritionists#index'
end
