class Post < ApplicationRecord
	# 여러 댓글을 가지고 있다.
	has_many :comments
end
