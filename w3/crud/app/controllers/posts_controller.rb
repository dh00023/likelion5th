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

		redirect_to "/posts/new/#{@post.id}"
	end

	# read
	def show
		@post = Post.find(params[:post_id])
	end

	def index
		@posts = Post.all
	end

	# destroy

	def destroy
		@post = Post.find(params[:post_id])
		@post.destroy

		redirect_to '/'
	end
end
