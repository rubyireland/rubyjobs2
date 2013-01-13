Rubyjobs2::Application.routes.draw do  
  resources :jobs
  
  match '/about_us', :to => redirect('/')
  root :to => 'jobs#index'  
end