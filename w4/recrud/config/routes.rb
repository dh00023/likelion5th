Rails.application.routes.draw do
  # RESTful한 페이지

  # Resource: posts

  # 우리가 쓴 글을 다 볼 수 있는 페이지
  get '/posts'=>'posts#index'
  # 우리가 새 글을 쓰는 페이지
  get '/posts/new'=>'posts#new'
  # 새 글을 받는 페이지(create)
  post '/posts'=>'posts#create'
  # 특정 글을 보는 페이지
  get '/posts/:id'=>'posts#show'
  # 글을 수정하는 페이지
  get '/posts/:id/edit'=>'posts#edit'
  # 글을 수정 완료하는 페이지
  put '/posts/:id'=>'posts#update'
  patch '/posts/:id'=>'posts#update'
  # 특정 글을 삭제하는 페이지
  delete '/posts/:id'=>'posts#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
