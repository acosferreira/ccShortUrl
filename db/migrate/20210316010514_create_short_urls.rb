class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :original_url
      t.string :shortened_url
      t.string :full_url

      t.timestamps
    end
  end
end
