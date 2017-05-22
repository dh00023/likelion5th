class Post < ApplicationRecord
	# 여러 댓글을 가지고 있다. 해당 post를 삭제하면 댓글들까지 삭제되는것.
	has_many :comments, dependent: :destroy
end
