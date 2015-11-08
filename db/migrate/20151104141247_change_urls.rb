class ChangeUrls < ActiveRecord::Migration
  def change
    add_index :urls, :short_url, :unique => true
    add_index :urls, :authentication_token
  end
end
