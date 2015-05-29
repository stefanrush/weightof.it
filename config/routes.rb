Rails.application.routes.draw do
  root to: 'libraries#index'
  get 'category/:slug', to: 'libraries#index'
end
