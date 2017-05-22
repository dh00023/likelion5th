class PostsController < ApplicationController
	# create

	def new
		# 사용자가 데이터를 입력할 화면
		# 자동으로 액션과 이름이 같은 뷰를 보여줘라
	end

	def create
		#입력받은 데이터를 실제 DB에 저장할 액션
		@post = Post.new
		@post.title = params[:input_title]
		@post.content = params[:input_content]
		@post.save

		redirect_to "/posts/show/#{@post.id}"
	end

	# read
	def show
		# 한개으 ㅣ포스트를 보여주는 view
		@post = Post.find(params[:post_id])
		# @commnets = Comment.where(Lpost_id => params[:post_id])
	end

	def index
		# 모든 포스트를 보여주는 view
		@posts = Post.all
	end

	# update

	def edit
		# 사용자가 수정하는 페이지
		@post = Post.find(params[:post_id])
	end

	def update	
		# 수정
		@post = Post.find(params[:post_id])
		@post.title = params[:input_title]
		@post.content = params[:input_content]
		@post.save

		redirect_to "/posts/show/#{@post.id}"
	end

	# destroy

	def destroy
		# 한개의 포스트를 삭제하는 액션
		@post = Post.find(params[:post_id])
		@post.destroy

		redirect_to '/'
	end

end
