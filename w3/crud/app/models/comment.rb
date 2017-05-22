class Comment < ApplicationRecord
  # Post에 속해있다.
  belongs_to :post
end
