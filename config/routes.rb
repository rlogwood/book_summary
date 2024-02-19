Rails.application.routes.draw do
  devise_for :users

  get 'about' => 'pages#about'
  get 'settings' => 'pages#settings'
  get 'chatgpt_models' => 'ai_models#chatgpt_models'
  get 'request_summary' => 'book_summary#request_summary'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'summarize', to: 'book_summary#summarize', as: 'summarize'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#about'
end
