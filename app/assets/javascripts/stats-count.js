getDeviceData = function()
{
    return {
        user_agent: window.navigator.userAgent,
        plataform: window.navigator.platform,
        browser: window.navigator.appCodeName,
        vendor: window.navigator.vendor,
        pixel_ratio: window.devicePixelRatio,
        resolution: screen.height + 'x' +  screen.width,
        language: window.navigator.language
    }
};

setStatus = function(status, level)
{
    send_status = $('#send-status');

    send_status.removeClass('label-success');
    send_status.removeClass('label-info');
    send_status.removeClass('label-important');

    if(level)
    {
        switch(level)
        {
            case 'success': send_status.addClass('label-success');
                break;

            case 'info': send_status.addClass('label-info');
                break;

            case 'fail': send_status.addClass('label-important');
                break;
        }
    }

    send_status.html(status)
};

setStatus('Getting device info', 'info');

$.ajax({
    type: 'POST',
    data: {
        'device_data': getDeviceData()   
    }
}).done(function(data)
{
    console.log(data);
    setStatus('Device info sent successfully', 'success');
}).fail(function(data){
    console.log(data);
    setStatus('Failed sending your device info', 'fail');
});
