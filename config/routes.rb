Rails.application.routes.draw do
  resources :urls, only: [:index, :new, :create]
  root 'urls#new'
  get 'my', to: 'urls#my'
  resources :reports, only: [:index]
  get 'per_day', to: 'reports#per_day'
  post 'per_day', to: 'reports#per_day'
  get ':short_url', to: 'urls#redirect'
end
