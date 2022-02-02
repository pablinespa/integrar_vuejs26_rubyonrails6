Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  namespace :api do
    namespace :v1, defaults: { format: 'json'} do
      ######## TEST ###########
      get 'test' => 'api#test', as: :test
      get 'users' => 'api#users', as: :users
      get 'services' => 'api#services', as: :services
      get 'weeks' => 'api#weeks', as: :weeks
      get 'days' => 'api#days', as: :days
    end
  end
end