# Scaffold

```
rails g scaffold Post title content:text
````

```
  invoke  active_record
      create    db/migrate/20170822150704_create_posts.rb
      create    app/models/post.rb
      invoke    test_unit
      create      test/models/post_test.rb
      create      test/fixtures/posts.yml
      invoke  resource_route
       route    resources :posts
      invoke  scaffold_controller
      create    app/controllers/posts_controller.rb
      invoke    erb
      create      app/views/posts
      create      app/views/posts/index.html.erb
      create      app/views/posts/edit.html.erb
      create      app/views/posts/show.html.erb
      create      app/views/posts/new.html.erb
      create      app/views/posts/_form.html.erb
      invoke    test_unit
      create      test/controllers/posts_controller_test.rb
      invoke    helper
      create      app/helpers/posts_helper.rb
      invoke      test_unit
      invoke    jbuilder
      create      app/views/posts/index.json.jbuilder
      create      app/views/posts/show.json.jbuilder
      create      app/views/posts/_post.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/posts.coffee
      invoke    scss
      create      app/assets/stylesheets/posts.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.scss
```

- scaffold를 사용하면 controller에 액션생성, 뷰파일 생성, route생성, 모델생성을 해준다.

## Controller
```ruby
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
      if @post.update(post_params)
     redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
```
- `private`는 controller내에서만 사용하는 것이다.
- `before_action`으로 코드를 줄일 수 있다.
- `redirect_to`는 해당 url로 이동한다.
- `render`는 해당 url로 이동하지 않고, 해당 내용물만 html이 바뀐다고 생각하면된다.

```ruby
# form_tag
params = {title: "title1", content: 'content1'}
# form_for
params = {post: {title: "title1",content: 'content1'}}
params.require(:post).permit(:title, :content)
```


title과 content만 꺼내온다. 이걸 Strong parameter라하는데 내가 원하는 parameter만 꺼내오는 것이다.

## _form.html.erb
```erb
<!-- edit.html.erb -->
<%= render 'form', post: @post %>
```

```erb
<!-- _form.html.erb -->
<%= form_for(post) do |f| %>
  <% if post.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(post.errors.count, "error") %> prohibited this post from being saved:</h2>

      <ul>
      <% post.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :title %>
    <%= f.text_field :title %>
  </div>

  <div class="field">
    <%= f.label :content %>
    <%= f.text_area :content %>
  </div>

  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```
`render`를 이용해서 간단하게 `_form.html.erb`파일을 불러올 수 있다. 이때 규칙이 있는데 꼭 `_`를 파일명 앞에 붙여줘야한다.