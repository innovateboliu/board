class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :id
      t.string :title
      t.text :content
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
