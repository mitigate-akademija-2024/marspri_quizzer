Rails.application.routes.draw do
  root 'main#index'

  get "/main", to: "main#index", as: "main"
  get "/start_quiz", to: "quizzes#start"

  resources :users, only: [:new, :create, :show]
  get '/profile', to: 'users#show', as: 'user_profile'
  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  
  resources :quizzes do
    get 'available', on: :collection
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end

    get 'continue', on: :member
    get 'completed', on: :collection
    get 'take', on: :member
    post 'submit', on: :member
    get 'results', on: :member
    get 'share_results', on: :member
    get 'shared_results', on: :member
    get 'top_scores', on: :member
    post 'submit_feedback', on: :member
    get 'feedbacks', on: :member
    delete 'destroy_feedback', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
