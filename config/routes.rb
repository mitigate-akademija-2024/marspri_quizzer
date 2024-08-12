Rails.application.routes.draw do

  root 'quizzes#index'

  get "/start_quiz", to: "quizzes#start"

  resources :quizzes do 
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
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
