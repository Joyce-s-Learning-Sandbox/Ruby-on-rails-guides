Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :articles
  
  delete "articles/:id" => "articles#destroy", as: "delete_article"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
