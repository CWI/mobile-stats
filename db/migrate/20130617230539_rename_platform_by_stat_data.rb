class RenamePlatformByStatData < ActiveRecord::Migration
  def up
      rename_column :stat_data, :plataform, :platform
  end

  def down
      rename_column :stat_data, :platform, :plataform
  end
end
