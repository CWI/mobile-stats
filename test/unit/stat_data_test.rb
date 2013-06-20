require 'test_helper'

class StatDataTest < ActiveSupport::TestCase
  set_fixture_class :stat_data => "StatData"
  fixtures :stat_data

  def test_stat_data
	first_stat_data = StatData.new( :event_name => stat_data(:first_event).event_name,
									:ip_address => stat_data(:first_event).ip_address,
									:user_agent => stat_data(:first_event).user_agent,
									:platform => stat_data(:first_event).platform,
									:browser => stat_data(:first_event).browser,
									:vendor => stat_data(:first_event).vendor,
									:pixel_ratio => stat_data(:first_event).pixel_ratio,
									:resolution => stat_data(:first_event).resolution,
									:language => stat_data(:first_event).language,
									:ios_version => stat_data(:first_event).ios_version,
									:android_version => stat_data(:first_event).android_version)

	assert first_stat_data.save

	first_stat_data_copy = StatData.find(first_stat_data.id)
	assert_equal first_stat_data.event_name, first_stat_data_copy.event_name
	
	first_stat_data.event_name = "Rename first event name"
	assert first_stat_data.save
	assert first_stat_data.destroy
  end
  
end
