Rails.application.routes.draw do
  get 'prueba/', to: 'prueba#index'
  get 'prueba/test_api', to: 'prueba#test_api'
  get 'prueba/results', to: 'prueba#results'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
