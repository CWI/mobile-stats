# encoding: utf-8
class StatsController < ApplicationController

  layout :resolve_layout

  def index
    if params[:event_name]
      slug_string = slug params[:event_name]
      redirect_to report_url slug_string, 'vendor'
    end
  end

  def report_redirect
    redirect_to report_url params[:event_name], 'vendor'
  end

  def report
  end

  def report_data
    @stat_data = StatData.report_data params[:event_name], params[:property]
    total_records = StatData.total_records @stat_data
    render :json => @stat_data.map { |stats| { total_stats: Integer(stats.total_stats), perc: stats.perc(total_records), property_value: stats.property_value } }
  end

  def qrcode
    @qr = "#{request.protocol}#{request.host_with_port}#{count_path}"
  end

  def count
    if request.post?
      @stat_data = StatData.new(params[:device_data])
      @stat_data.event_name = params[:event_name]
      @stat_data.ip_address = request.remote_ip

      render :json => {message: save_stat_data}
    end
  end

  def clear
    if params[:event_name_delete]
      event_name_delete = slug params[:event_name_delete]
      if event_name_delete == params[:event_name]
        StatData.delete_all(['event_name = ?', event_name_delete])
        redirect_to report_url event_name_delete, 'vendor'
      else
        flash[:error] = "Você digitou o nome incorreto."
      end
    end
  end

  private

  def save_stat_data
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

  def resolve_layout
    case action_name
    when "report"
      "clean"
    else
      "application"
    end
  end

  def slug(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
