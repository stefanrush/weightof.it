Rails.application.routes.draw do
  root                   to: 'libraries#index'
  get  'category/:slug', to: 'libraries#index'
  get  'contribute',     to: 'libraries#new'
  post 'contribute',     to: 'libraries#create', as: :libraries
end
