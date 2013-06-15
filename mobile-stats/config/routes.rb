MobileStats::Application.routes.draw do
  root :to => 'stats#index'
  match ':id' => 'stats#home', :as => :stat_home
  match ':id/report' => 'stats#report', :as => :report
  match ':id/qrcode' => 'stats#qrcode', :as => :qrcode
  match ':id/countme' => 'stats#count', :as => :count
end
