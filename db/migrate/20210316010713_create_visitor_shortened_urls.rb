class CreateVisitorShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :visitor_shortened_urls do |t|
      t.string :ip_request
      t.references :short_url, foreign_key: true

      t.timestamps
    end
  end
end
