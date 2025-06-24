class AddUserAndLikeableToLikes < ActiveRecord::Migration[8.0]
  def change
    add_reference :likes, :user, null: false, foreign_key: true
    add_reference :likes, :likeable, polymorphic: true, null: false
  end
end
