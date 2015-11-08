class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :full_url
      t.string :short_url
      t.boolean :active
      t.string :authentication_token
      t.timestamps null: false
    end
  end
end
