Rubyjobs2::Application.routes.draw do  
  resources :jobs
  
  match '/about_us' => 'pages#about_us'
  root :to => 'jobs#index'  
end