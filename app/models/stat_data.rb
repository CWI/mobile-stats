class StatData < ActiveRecord::Base
  attr_accessible :event_name, :ip_address, :user_agent, :platform, :browser, :vendor, :pixel_ratio, :resolution, :language, :ios_version, :android_version, :property_value, :total_stats, :perc
  attr_accessor :perc
end
