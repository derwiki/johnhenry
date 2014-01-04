Rails4payment::Engine.routes.draw do
  root 'home#welcome'
  resources :payments

  devise_for :users, controllers: { registrations: 'rails4payment/registrations' }
end
