Rails.application.routes.draw do
  resources :lines, only: [:show]
end
