Rails.application.routes.draw do

  get '/', to: 'welcome#index'

  get '/schools/new', to: 'schools#new'
  get '/schools/:id/students/new', to: 'students#new'
  get '/schools/:id/students', to: 'schools#students'
  get '/schools/:id/degrees', to: 'schools#degrees'
  get '/schools/:id/edit', to: 'schools#edit'
  get '/schools/:id', to: 'schools#show'
  get '/schools', to: 'schools#index'

  get '/students/:id/edit', to: 'students#edit'
  get '/students/:id', to: 'students#show'
  get '/students', to: 'students#index'

  post '/schools/new', to: 'schools#create'
  post '/schools/:id/students/new', to: 'students#create'
  post '/schools/:id/students', to: 'schools#students'

  patch '/schools/:id/edit', to: 'schools#update'
  patch '/students/:id/edit', to: 'students#update'

  delete '/schools/:id', to: 'schools#destroy'
  delete '/students/:id', to: 'students#destroy'

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
