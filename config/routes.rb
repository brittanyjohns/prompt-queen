Rails.application.routes.draw do
  get 'responses/index'
  get 'responses/show'
  resources :responses
  # Defines the root path route ("/")
  root "prompt_templates#index"
  resources :prompt_templates do
    resources :prompts do
      member do
        post "prompt_images", to: "prompts#prompt_images"
        post "prompt_text", to: "prompts#prompt_text"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
