class ChangeColumnChannel < ActiveRecord::Migration[5.0]
  # Youtubeからの最終取り込み日を、dateからtimestampに
  def up
    change_column :channels, :last_imported_at, :timestamp
  end

  def down
    change_column :channels, :last_imported_at, :date
  end
end
