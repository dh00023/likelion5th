Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'posts/new'
  post 'posts/create'

  root 'posts#index'
  get 'posts/show/:post_id' => 'posts#show'

  post 'posts/destroy/:post_id' => 'posts#destroy'

  get 'posts/edit/:post_id' => 'posts#edit'
  post 'posts/update/:post_id' => 'posts#update'
end
