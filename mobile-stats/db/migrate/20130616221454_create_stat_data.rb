class CreateStatData < ActiveRecord::Migration
  def change
    create_table :stat_data do |t|
      t.string :event_name
      t.string :ip_address
      t.string :user_agent
      t.string :plataform
      t.string :browser
      t.string :vendor
      t.string :pixel_ratio
      t.string :resolution
      t.string :language
      t.timestamps
    end
  end
end
