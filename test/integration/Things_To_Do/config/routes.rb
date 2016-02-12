ThingsApplication.route.draw do
  get "/", to: "todo#index"
  resources :todo
   # "/:controller/:action"
end
