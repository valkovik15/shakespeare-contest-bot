Rails.application.routes.draw do
  resources :inputs
  resources :histories
  root 'inputs#index'
  post "/quiz" => "quiz#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
