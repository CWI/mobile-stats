class StatData < ActiveRecord::Base
  attr_accessible :event_name, :ip_address, :user_agent, :plataform, :browser, :vendor, :pixel_ratio, :resolution, :language, :total_stats
end
