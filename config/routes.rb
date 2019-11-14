Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :articles do
    resources :comments
  end 
    # This creates comments as a nested resource within articles. This is another part of capturing the hierarchical relationship that exists between articles and comments.
  

  delete "articles/:id" => "articles#destroy", as: "delete_article"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
