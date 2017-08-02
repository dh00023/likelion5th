# Re-CRUD

## 1. CSRF
사이트 간 요청 위조(또는 크로스 사이트 요청 위조, 영어: Cross-site request forgery, CSRF, XSRF)는 웹사이트 취약점 공격의 하나로, 사용자가 자신의 의지와는 무관하게 공격자가 의도한 행위(수정, 삭제, 등록 등)를 특정 웹사이트에 요청하게 하는 공격을 말한다.


```ruby
# application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
```

예를들면 다른 페이지에서 글을 썼는데 우리 페이지에 글이 올라가는 경우나 다른 페이지에서 글을 삭제 할 수 있게되는 경우이다.

위의 코드를 주석처리하게되면 이러한 CSRF 공격을 막을 수 없게된다.


## 2. form_helper
인증토큰을 사용하기위해서는 Rails의 `form_helper`를 사용해야한다.
- [한글 가이드](http://guides.rorlab.org/form_helpers.html)

```erb
<h1>새로운 post를 입력할 화면</h1>
<%= form_tag '/posts/create', method: 'post' do %>
	<p><%= text_field_tag 'title',nil,style: 'width:33%'%></p>
	<!-- 순서대로 name, value, style이나 id값을 써주면된다. -->
	<p><%= text_area_tag 'content',nil,style: 'width:33%',rows: 20%></p>
	<%= submit_tag '제출' %>
<% end %>
```
`form_helper`를 사용할 경우에 hidden input이 2개가 자동으로 생기는 것을 확인할 수 있다.

## 3. REST(Representational State Transfer)
자원을 정의하고 자원에 대한 주소를 지정하는 방법들의 모음

레일즈에서는 RESTful하게 적용한다.

- Resource : 우리가 다루려는 대상
- Method : 그 대상에 취하는 조치
	- Get(Read) : 무언가를 요청(URL에 명시적으로 내용이 보여짐)
	- Post(Create) : 생성을 요청(URL/URI 에 생성한 내용이 보여지지 않음)
	- Put/Patch(Update)
	- Delete(Delete)
- Message

## 4. Route

```ruby
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
```
|method|uri|Controller#Action|설명|
|:------:|:------:|:------:|:------:|
| get | /posts |posts#index| 우리가 쓴 글을 다 볼 수 있는 페이지|
| get|/posts/new|posts#new| 우리가 새 글을 쓰는 페이지|
| post|/posts|posts#create| 새 글을 받는 페이지|
| get |/posts/:id|posts#show| 특정 글을 보는 페이지|
| get |/posts/:id/edit|posts#edit| 글을 수정하는 페이지|
| put |/posts/:id|posts#update| 글을 수정 완료하는 페이지|
| patch |/posts/:id|posts#update| 글을 수정 완료하는 페이지|
| delete| /posts/:id|posts#destroy| 특정 글을 삭제하는 페이지|

