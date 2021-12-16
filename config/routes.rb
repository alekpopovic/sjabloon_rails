Rails.application.routes.draw do
  post 'subscribers', to: 'sjabloon/subscribers#create'
  get '/subscribe', to: 'pages#subscribe'
  resources :consents, module: 'sjabloon', only: [:create]
  get '/:policy_type', to: 'sjabloon/policies#show', as: :policy, constraints: { policy_type: /terms|privacy|cookies/ }
  post 'signups', to: 'sjabloon/signups#create'
  get 'signup', to: 'sjabloon/signups#new'
  devise_for :users, path: "/", path_names: { sign_in: "login", sign_out: "logout", edit: "edit" }
  get '/contact', to: 'pages#contact'
  get '/about', to: 'pages#about'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
