if(!MOBILE_STATS)
	var MOBILE_STATS={};

MOBILE_STATS.COUNT = {
	containers: {},
	status: {fail: 'fail', success: 'success', info: 'info'},

	init: function() {
		MOBILE_STATS.COUNT.getContaineirs();
	},

	getContaineirs: function() {
		MOBILE_STATS.COUNT.containers.sendStatus = $('#send-status');
		MOBILE_STATS.COUNT.containers.deviceData = MOBILE_STATS.COUNT.getDeviceData();
	},

	getDeviceData: function()
	{
		return {
			user_agent: window.navigator.userAgent,
			platform: window.navigator.platform,
			browser: window.navigator.appCodeName,
			vendor: window.navigator.vendor,
			pixel_ratio: window.devicePixelRatio,
			resolution: screen.width + 'x' +  screen.height,
                        // lower case to avoid different stats for the same language
			language: window.navigator.language.toLowerCase()
		}
	},

	setStatus: function(status, level)
	{
		MOBILE_STATS.COUNT.containers.sendStatus.removeClass('label-success');
		MOBILE_STATS.COUNT.containers.sendStatus.removeClass('label-info');
		MOBILE_STATS.COUNT.containers.sendStatus.removeClass('label-important');

		if(level)
		{
			switch(level)
			{
				case MOBILE_STATS.COUNT.status.success:
					MOBILE_STATS.COUNT.containers.sendStatus.addClass('label-success');
					break;

				case MOBILE_STATS.COUNT.status.info:
					MOBILE_STATS.COUNT.containers.sendStatus.addClass('label-info');
					break;

				case MOBILE_STATS.COUNT.status.fail:
					MOBILE_STATS.COUNT.containers.sendStatus.addClass('label-important');
					break;
			}
		}

		MOBILE_STATS.COUNT.containers.sendStatus.html(status)
	},

	setStatusMessage: function(key)
	{
		switch(key)
		{
			case 'success':
				MOBILE_STATS.COUNT.setStatus('Device info sent successfully', MOBILE_STATS.COUNT.status.success);
				break;

			case 'fail':
				MOBILE_STATS.COUNT.setStatus('Failed sending your device info', MOBILE_STATS.COUNT.status.fail);
				break;

			case 'duplicated':
				MOBILE_STATS.COUNT.setStatus('Device info already sent to server', MOBILE_STATS.COUNT.status.info);
				break;
		}
	},

	sendDeviceInfos: function()
	{
		$.ajax({
			type: 'POST',
			data: {
				'device_data': MOBILE_STATS.COUNT.containers.deviceData
			}
		}).done(function(data)
		{
			MOBILE_STATS.COUNT.setStatusMessage(data.message)
		}).fail(function(data)
		{
			MOBILE_STATS.COUNT.setStatusMessage('fail');
		});
	}
};

$(document).ready(function() {
	MOBILE_STATS.COUNT.init();
	MOBILE_STATS.COUNT.sendDeviceInfos();
});
