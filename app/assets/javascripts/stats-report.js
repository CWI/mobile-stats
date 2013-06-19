//= require Chart

if(!MOBILE_STATS)
  var MOBILE_STATS={};

MOBILE_STATS.REPORT = {
  containers: {},

  pulling_rate: 10000,

  table_line_template: '<tr><td>{desc}</td><td>{qty}</td><td>{perc}%</td></tr>',

  init: function() {
    MOBILE_STATS.REPORT.getContaineirs();
    MOBILE_STATS.REPORT.initChart();
  },

  getContaineirs: function() {
    MOBILE_STATS.REPORT.containers.chart_container = $('#chart-container');
    MOBILE_STATS.REPORT.containers.table_body = $('#grid-container tbody');
    // MOBILE_STATS.REPORT.containers.deviceData = MOBILE_STATS.COUNT.getDeviceData();
  },

  getReportOption: function() {
    return $('#property_name').val();
  },

  startPulling: function() {
    MOBILE_STATS.REPORT.pullContent();
  },

  initChart: function() {
    //Get context with jQuery - using jQuery's .get() method.
    var chart_canvas = $("#chart");

    var calculated_height = Math.max($('body').height(), $(window).height()) - MOBILE_STATS.REPORT.containers.chart_container.offset().top - 60;

    if (calculated_height < 100)
      calculated_height = MOBILE_STATS.REPORT.containers.chart_container.width();

    MOBILE_STATS.REPORT.containers.chart_container.height(calculated_height);

    chart_canvas.attr('width', MOBILE_STATS.REPORT.containers.chart_container.width());
    chart_canvas.attr('height', MOBILE_STATS.REPORT.containers.chart_container.height());

    var ctx = chart_canvas.get(0).getContext("2d");
    //This will get the first returned node in the jQuery collection.
    MOBILE_STATS.REPORT.chart = new Chart(ctx);
  },

  setTableData: function(data) {
    var tbody = '';

    for(var i = 0; i < data.length; i++)
      tbody += MOBILE_STATS.REPORT.table_line_template
        .replace('{desc}', data[i].property_value)
        .replace('{qty}', data[i].total_stats)
        .replace('{perc}', data[i].perc);

    MOBILE_STATS.REPORT.containers.table_body.html(tbody);
  },

  setChartData: function(data) {
    MOBILE_STATS.REPORT.restartColors();

    var chart_data = [];

    for(var i = 0; i < data.length; i++)
      chart_data[chart_data.length] = {
        value: data[i].total_stats,
        color: MOBILE_STATS.REPORT.getChartColor()
      }

    MOBILE_STATS.REPORT.chart.Doughnut(chart_data, {
      segmentShowStroke: false,
      animation: false
    });
  },

  restartColors: function() {
    MOBILE_STATS.REPORT.chartColorIndex = 0;
  },

  getChartColor: function() {
    var chart_colors = ["#FDC332", "#FD8232", "#FFD214", "#FF0418", "#FFAB00", "#868583", "#FF5A00", "#FF9900" ];

    if ((MOBILE_STATS.REPORT.chartColorIndex == undefined) || (MOBILE_STATS.REPORT.chartColorIndex >= chart_colors.length))
      MOBILE_STATS.REPORT.chartColorIndex = 0;

    return_color = chart_colors[MOBILE_STATS.REPORT.chartColorIndex];

    MOBILE_STATS.REPORT.chartColorIndex++;

    return return_color;
  },

  pullContent: function() {
    $.ajax({
      url: MOBILE_STATS.REPORT.getReportOption() + '/data',
      dataType: 'json'
    }).done(function(data)
    {
      MOBILE_STATS.REPORT.setChartData(data);
      MOBILE_STATS.REPORT.setTableData(data);

      MOBILE_STATS.REPORT.last_result = data;
    }).fail(function(data)
    {
      console.log('FAIL!', data)
    });

    window.setTimeout(MOBILE_STATS.REPORT.pullContent, MOBILE_STATS.REPORT.pulling_rate);
  }
};

$(document).ready(function() {
  MOBILE_STATS.REPORT.init();
  MOBILE_STATS.REPORT.startPulling();
});
