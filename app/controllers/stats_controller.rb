class StatsController < ApplicationController

  layout :resolve_layout

  def index
    if params[:event_name]
      redirect_to report_url params[:event_name], 'vendor'
    end
  end

  def report_redirect
    redirect_to report_url params[:event_name], 'vendor'
  end

  def report
  end

  def report_data
    property = params[:property]
    @stat_data = StatData.select("count(*) as total_stats, #{property} as property_value")
      .where('event_name = ?', params[:event_name])
      .group(property)
      .order('total_stats desc')

    total_records = 0

    @stat_data.each do |i|
      total_records += Integer(i.total_stats)
    end

    @stat_data = @stat_data.collect do |i|
      i.perc = ((i.total_stats.to_f / total_records.to_f) * 100.0).round
      i
    end

    render :json => @stat_data.map { |stats| {:total_stats => stats.total_stats, :perc => stats.perc, :property_value => stats.property_value} }
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
