class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :channel_id
      t.string :video_id
      t.string :title
      t.string :thumb_url
      t.timestamp :published_at

      t.timestamps
    end
  end
end
