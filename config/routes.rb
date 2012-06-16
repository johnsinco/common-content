Rails.application.routes.draw do
 # root :to => '404.html' 
 resources :contents do
  member do
    put 'renovate'
    get 'define'
  end
 end
end
