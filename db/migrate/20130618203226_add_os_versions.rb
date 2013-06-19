class AddOsVersions < ActiveRecord::Migration
  def change
    add_column :stat_data, :iphone_version, :string
    add_column :stat_data, :android_version, :string
  end
end
