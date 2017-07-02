class AddColumnChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :last_imported_at,  :date, :after => :c_id
  end
end
