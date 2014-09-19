class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :hashtag
      t.string :desc
      t.string :loc
      t.string :lat
      t.string :long

      t.timestamps
    end
  end
end
