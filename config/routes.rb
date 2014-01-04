Rails4payment::Engine.routes.draw do
  root 'home#welcome'
  resources :payments

  devise_for :users, controllers: {
    unlocks: 'rails4payment/unlocks',
    sessions: 'rails4payment/sessions',
    passwords: 'rails4payment/passwords',
    confirmations: 'rails4payment/confirmations',
    registrations: 'rails4payment/registrations',
  }
end
