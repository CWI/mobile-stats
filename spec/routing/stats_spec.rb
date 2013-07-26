#encoding: utf-8
require 'spec_helper'

describe 'Stats' do

  context 'GET xxx/report' do
    it { expect(get 'xxx/report').to route_to(controller: 'stats', action: 'report_redirect', event_name: 'xxx') }
  end
  context 'GET xxx/report/yyy' do
    it { expect(get 'xxx/report/yyy').to route_to(controller: 'stats', action: 'report', event_name: 'xxx', property: 'yyy') }
  end
  context 'GET xxx/report/yyy/data' do
    it { expect(get 'xxx/report/yyy/data').to route_to(controller: 'stats', action: 'report_data', event_name: 'xxx', property: 'yyy') }
  end
  context 'GET xxx/qrcode' do
    it { expect(get 'xxx/qrcode').to route_to(controller: 'stats', action: 'qrcode', event_name: 'xxx') }
  end
  context 'GET xxx/countme' do
    it { expect(get 'xxx/countme').to route_to(controller: 'stats', action: 'count', event_name: 'xxx') }
  end
  context 'GET xxx/clear-this-mess' do
    it { expect(get 'xxx/clear-this-mess').to route_to(controller: 'stats', action: 'clear', event_name: 'xxx') }
  end

end