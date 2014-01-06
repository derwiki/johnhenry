JohnHenry::Engine.routes.draw do
  root 'home#welcome'
  resources :payments

  devise_for :users, controllers: {
    unlocks: 'johnhenry/unlocks',
    sessions: 'johnhenry/sessions',
    passwords: 'johnhenry/passwords',
    confirmations: 'johnhenry/confirmations',
    registrations: 'johnhenry/registrations',
  }
end
