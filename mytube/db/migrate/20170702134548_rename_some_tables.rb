class RenameSomeTables < ActiveRecord::Migration[5.0]
  def change
    rename_column :videos, :video_id, :youtube_video_id
    rename_column :channels, :c_id, :youtube_channel_id
    add_index :videos, :channel_id
    add_index :user_channels, :user_id
  end
end
