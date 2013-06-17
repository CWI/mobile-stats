class StatsController < ApplicationController

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

      if @stat_data.save
        message = {message: 'Success'}
      else
        message = {message: 'Fail'}
      end

      render :json => message
    else
    end
  end

end
