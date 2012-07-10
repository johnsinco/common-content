Rails.application.routes.draw do
 # root :to => '404.html' 
 resources :contents do
 end

  match 'contents/resources/:resource_type' => 'contents#resource_edit' 
  match 'contents/*ancestors/:id/edit' => 'contents#edit' 
  match 'contents/*ancestors/:id' => 'contents#update', :via => [:put] 
  match 'contents/*ancestors/:id' => 'contents#show' 
end
