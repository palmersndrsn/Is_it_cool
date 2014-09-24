class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :name
      t.string :hashtag
      t.string :desc
      t.string :loc
      t.integer :lat
      t.integer :long
      t.string :tweet_count
      t.string :date

      t.timestamps
    end
  end
end
