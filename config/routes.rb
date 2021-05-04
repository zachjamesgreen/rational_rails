Rails.application.routes.draw do
  get '/authors', to: "author#index"
  get '/author/new', to: "author#new"
  post '/author/new', to: "author#create"
  patch '/author/update', to: "author#update"
  delete '/author/delete', to: "author#delete"
  get '/author/edit', to: "author#edit"
end
