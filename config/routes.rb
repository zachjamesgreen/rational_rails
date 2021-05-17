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

  delete '/schools/:id/students', to: 'students#destroy'
  delete '/schools/:id', to: 'schools#destroy'
  delete '/students/:id', to: 'students#destroy'

  get '/stories', to: 'story#index'
  get '/stories/:id',to: 'story#show'
  get '/stories/:id/edit', to: 'story#edit'
  post '/stories/:id', to: 'story#update'
  delete '/stories/:id', to: 'story#delete', as: :story_delete

  get '/authors/:id/stories/new', to: 'story#new'
  post '/authors/:id/stories', to: 'story#create'

  get '/authors', to: 'author#index'
  get '/authors/new', to: 'author#new'
  get '/authors/:id', to: 'author#show'
  post '/authors/new', to: 'author#create'
  post '/authors/:id', to: 'author#update'
  delete '/authors/delete', to: 'author#delete'
  get '/authors/:id/edit', to: 'author#edit'
  get '/authors/:id/stories', to: 'author#show_with_stories'
  delete '/authors/:id', to: 'author#delete'
end
