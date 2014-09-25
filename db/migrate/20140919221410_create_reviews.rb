class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :body
      t.string :cool
      t.string :ratio
      t.string :grime


      t.timestamps
    end
  end
end
