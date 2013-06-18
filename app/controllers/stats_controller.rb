class StatsController < ApplicationController

  layout :resolve_layout

  def index
    if params[:event_name]
      redirect_to report_url params[:event_name]
    end
  end

  def report

  end

  def report_data
    property = params[:property]
    @stat_data = StatData.select("count(*) as total_stats, #{property}")
      .where('event_name = ?', params[:event_name])
      .group(property)
      .order('total_stats desc')

    render :json => @stat_data
  end

  def qrcode
  end

  def count
    if request.post? 
      @stat_data = StatData.new(params[:device_data])
      @stat_data.event_name = params[:event_name]
      @stat_data.ip_address = request.remote_ip
    
      render :json => {message: _saveStatData}
    end
  end

  private

  def _saveStatData
  all_events = {}
    if cookies[:sent_count_stats]
    all_events = Marshal.load(cookies[:sent_count_stats]) 
    end
    
    message = 'fail'
    if all_events and all_events[params[:event_name]]
      message = 'duplicated'
    elsif @stat_data.save
      all_events = all_events.merge!({params[:event_name] => true}) { |key, v1, v2| v1 }
      message = 'success'
    end
  
    cookies[:sent_count_stats] = { :value => Marshal.dump(all_events), :expires => 1.hour.from_now }
    return message;
  end 

  private

  def resolve_layout
    case action_name
    when "report"
      "clean"
    else
      "application"
    end
  end

end
