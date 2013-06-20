class ChangeIosColumn < ActiveRecord::Migration
  def up
      rename_column :stat_data, :iphone_version, :ios_version
  end

  def down
      rename_column :stat_data, :ios_version, :iphone_version
  end
end
