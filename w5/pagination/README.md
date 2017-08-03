# Pagination
페이지를 나눠서 보여준다.

- [gem kaminari](https://github.com/kaminari/kaminari)

## Gem install
```
gem 'kaminari'
```
```
$ bundle install
```

## Kaminari 시작하기
```ruby
class PostsController < ApplicationController
	def index
		@posts = Post.page params[:page]
	end
end
```

```erb
<!-- index.html.erb -->
<% @posts.each do |post| %>
	<p><%=post.id%> <%=post.title%></p>
<% end %>
<%= paginate @posts %>
```

## 옵션설정
```
$ rails g kaminari:config
	 create  config/initializers/kaminari_config.rb
```

`config/initializers`는 서버가 시작할때 자동으로 실행한다.

```ruby
# frozen_string_literal: true
Kaminari.configure do |config|
  config.default_per_page = 5
  # config.max_per_page = nil
  config.window = 1 # 양옆 숫자를 의미한다.
  config.outer_window = 0 #양쪽 끝의 보여지는 숫자를 의미한다.
  config.left = 2
  config.right = 2
  # config.page_method_name = :page
  # config.param_name = :page
  # config.params_on_first_page = false
end
```

## I18n and Labels
```ruby
#config/locales/en.yml

en:
  views:
    pagination:
      first: "처음"
      last: "마지막"
      previous: "이전"
      next: "다음"
      truncate: "하하"
```