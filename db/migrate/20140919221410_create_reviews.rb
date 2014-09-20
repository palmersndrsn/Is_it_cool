class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :body
      t.string :img_url
      t.string :raito
      t.string :grime

      t.timestamps
    end
  end
end
