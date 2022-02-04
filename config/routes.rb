Rails.application.routes.draw do

  root "forecasts#new"

  get 'forecasts/index'
  get 'forecasts/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
