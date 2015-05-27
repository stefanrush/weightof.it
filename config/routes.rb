Rails.application.routes.draw do
  root to: 'libraries#index'
  get '(category/:slug)(/)(search/:query)(/)(page/:page)', to: 'libraries#index'
end
