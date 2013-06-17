MobileStats::Application.routes.draw do
  root :to => 'stats#index'
  match ':event_name/report' => 'stats#report', :as => :report
  match ':event_name/report/data/:property' => 'stats#report_data', :as => :report_data
  match ':event_name/qrcode' => 'stats#qrcode', :as => :qrcode
  match ':event_name/countme' => 'stats#count', :as => :count
end
