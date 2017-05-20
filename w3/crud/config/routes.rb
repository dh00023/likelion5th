Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'posts/new'
  get 'posts/create'

  root 'posts#index'
  get 'posts/show/:post_id' => 'posts#show'

  get '/posts/destroy/:post_id' => 'posts#destroy'
end
