Rails.application.routes.draw do
 # root :to => '404.html' 
 resources :contents do
  resources :contents
 end
 
end
