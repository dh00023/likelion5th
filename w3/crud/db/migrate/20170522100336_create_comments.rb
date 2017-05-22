class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content
      #t.references :post, foreign_key: true
      t.belongs_to :post
      # t.integer :post_id와 같다.

      t.timestamps
    end
  end
end