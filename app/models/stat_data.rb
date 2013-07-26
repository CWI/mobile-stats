class StatData < ActiveRecord::Base
  attr_accessible :event_name, :ip_address, :user_agent, :platform, :browser, :vendor, :pixel_ratio, :resolution, :language, :ios_version, :android_version, :property_value, :total_stats
  attr_accessor :property, :property_value, :total_stats

  def self.report_data(event_name, property)
    if (property == "android_version" or property == "ios_version")
      # if don't have device version for android or iphone, then remove of query 
      filled_report_data event_name, property
    else
      all_report_data event_name, property
    end
  end

  def self.all_report_data(event_name, property)
    StatData.select("count(*) as total_stats, #{property} as property_value")
                           .where('event_name = ?', event_name)
                           .group(property)
                           .order('total_stats desc')
  end

  def self.filled_report_data(event_name, property)
    StatData.select("count(*) as total_stats, #{property} as property_value")
                           .where('event_name = ?', event_name)
                           .where(property + " is not null")
                           .where(property + " != ''")
                           .group(property)
                           .order('total_stats desc')
  end

  def self.total_records(data)
    total_records = 0
    data.each do |i|
      total_records += Integer(i.total_stats)
    end
    total_records
  end

  def perc(total_records)
    ( (total_stats.to_f / total_records) * 100.0).round
  end

end