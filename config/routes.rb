Rails.application.routes.draw do
  # get 'app/index'
  #
  # Apunto al controlador 'app' y llamo a su método 'index'
  root :to => "app#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
