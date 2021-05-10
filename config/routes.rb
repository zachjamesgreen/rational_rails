Rails.application.routes.draw do

  get '/story', to: 'story#index'
  get '/story/:id',to: 'story#show'
  # get '/story/delete'
  # get '/story/edit'
  # get '/story/new'
  # get '/story/update'


  get '/authors', to: 'author#index'
  get '/author/new', to: 'author#new'
  get 'author/:id', to: 'author#show'
  post '/author/new', to: 'author#create'
  patch '/author/:id', to: 'author#update'
  delete '/author/delete', to: 'author#delete'
  # get '/author/edit', to: 'author#edit'
  get '/author/:id/edit', to: 'author#edit'
  get 'author/:id/stories', to: 'author#show_with_stories'
end
