Rails.application.routes.draw do

  get '/schools/:id/students', to: 'schools#students'
  get '/schools/:id', to: 'schools#show'
  get '/schools', to: 'schools#index'

  get '/students/:id', to: 'students#show'
  get '/students', to: 'students#index'

  get '/story', to: 'story#index'
  get '/story/:id',to: 'story#show'
  get '/story/:id/edit', to: 'story#edit'
  post '/story/:id', to: 'story#update'
  delete '/story/:id', to: 'story#delete', as: :story_delete

  get '/author/:id/story/new', to: 'story#new'
  post '/author/:id/story', to: 'story#create'

  get '/authors', to: 'author#index'
  get '/author/new', to: 'author#new'
  get '/author/:id', to: 'author#show'
  post '/author/new', to: 'author#create'
  post '/author/:id', to: 'author#update'
  delete '/author/delete', to: 'author#delete'
  get '/author/:id/edit', to: 'author#edit'
  get '/author/:id/stories', to: 'author#show_with_stories'
  delete '/author/:id', to: 'author#delete'
end
