class CreateTwitts < ActiveRecord::Migration
  def change
    create_table :twitts do |t|
      t.string :message
      t.timestamps null: false
    end
  end
end
