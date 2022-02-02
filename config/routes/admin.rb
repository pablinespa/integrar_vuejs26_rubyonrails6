Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  # root to: "frontend#index"
  #
  namespace :admin do
    root action: 'login'
    get 'index' => 'dashboard#index', as: :index


    get 'login'
    post 'login'
    get 'forgot_password'
    post 'forgot_password'
    get 'register'
    post 'register'
    get 'logout'

    post 'post_upload'=>'posts#upload'

    resources :users do
      collection do
        post 'bulk_actions'
      end
    end

    resources :services do
      collection do
        post 'bulk_actions'
      end
    end

    resources :turns do
      collection do
        post 'bulk_actions'
      end
    end

  end

end