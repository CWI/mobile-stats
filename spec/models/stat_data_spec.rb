# encoding: utf-8

require 'spec_helper'

describe StatData do

	# it { should have_field(:event_name) }
	# it { should have_field(:ip_address) }
	# it { should have_field(:user_agent) }
	# it { should have_field(:platform) }
	# it { should have_field(:browser) }
	# it { should have_field(:vendor) }
	# it { should have_field(:pixel_ratio) }
	# it { should have_field(:resolution) }
	# it { should have_field(:language) }
	# it { should have_field(:ios_version) }
	# it { should have_field(:android_version) }
	# it { should have_field(:property_value) }
	# it { should have_field(:total_stats) }
	# it { should have_field(:perc) }

	describe 'perc' do
	
		subject { FactoryGirl.build(:stat_data).perc(total_records) }

		context 'total_records is 2' do
			let(:total_records) { 2 }

			it { should be 100 }
		end

		context 'total_records is 2' do
			let(:total_records) { 4 }

			it { should be 50 }
		end

	end

	describe 'self.total_records' do

		subject { StatData.total_records data }

		context '3 stats' do
			let(:data) { [*1..3].map {|i| FactoryGirl.build(:stat_data)} }

			it { should be 6 }
		end

	end

	describe 'self.report_data' do

		subject { StatData.report_data 'xxx', property }

		before do
			StatData.stub(:filled_report_data).and_return(true)
			StatData.stub(:all_report_data).and_return(true)
		end

		context 'is android' do
			let(:property) { 'android_version'}

			it 'should call filled_report data' do
				StatData.should_receive(:filled_report_data)
				subject
			end
		end

		context 'is not android neither ios' do
			let(:property) { 'xxx' }

			it 'should call all_report_data' do
				StatData.should_receive(:all_report_data)
				subject
			end
		end
	end

end