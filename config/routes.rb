# == Route Map
#
#     Prefix Verb URI Pattern               Controller#Action
#       root GET  /                         libraries#index
#            GET  /category/:slug(.:format) libraries#index
# contribute GET  /contribute(.:format)     libraries#new
#  libraries POST /contribute(.:format)     libraries#create
#

Rails.application.routes.draw do
  root                   to: 'libraries#index'
  get  'category/:slug', to: 'libraries#index'
  get  'contribute',     to: 'libraries#new'
  post 'contribute',     to: 'libraries#create', as: :libraries

  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
