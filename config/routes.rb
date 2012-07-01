Rails.application.routes.draw do
 # root :to => '404.html' 
 resources :contents do
 end

  match 'contents/*ancestors/:id/edit' => 'contents#edit' 
  match 'contents/*ancestors/:id' => 'contents#show' 
end
