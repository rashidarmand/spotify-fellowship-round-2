Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    resources :calendars
  end
  post '/sign_in', to: 'home#sign_in'
  delete '/sign_out', to: 'home#sign_out'
  get '/calendar', to: 'home#calendar'
  root 'home#index'
end
