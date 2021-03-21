Rails.application.routes.draw do
  resources :articles
  root 'articles#index'
  get 'about', to: 'pages#about'
end
