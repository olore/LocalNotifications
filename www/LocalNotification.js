/**
	Phonegap LocalNotification Plugin

  iOS/Android  (this file)
    Unified by Brian Olore 2012
	  MIT Licensed

  iOS  (original)
	  Copyright (c) Greg Allen 2011
	  Updates Drew Dahlman 2012
	  MIT Licensed

  Android (original)
    Created by Daniel van 't Oever 2012 MIT Licensed
**/

var LocalNotification = (function (cordova) {

  function LocalNotification() {};

	LocalNotification.add = function(options) {
/*
FOR REFERENCE:
    var defaults = {
      id:           0,      //Android String ("0")
      date:         false,  //Android defaults to new Date()
      message:      '',     //same
      hasAction:    true,   //iOS only
      action:       'View', //iOS only
      badge:        0,      //iOS only
			sound:        '',     //iOS only
			background:   '',     //iOS only
			foreground:   '',     //iOS only
      ticker:       '',     //Android only
      repeatDaily:  false,  //Android only
    };
*/

    var defaultsAndroid = {
      id:           "0",        
      date:         new Date(),
      message:      '',
      ticker:       '',     
      repeatDaily:  false, 
    };

    var defaultsIOS = {
      id:           0,
      date:         false,
      message:      '',
      hasAction:    true,
      action:       'View',
      badge:        0,
			sound:        '',
			background:   '',
			foreground:   '',
    };

    var defaults = defaultsIOS;
    if (device.platform.toLowerCase() == 'android') {
      defaults = defaultsAndroid;
    }

    for (var key in defaults) {
      if (typeof options[key] !== "undefined") {
        defaults[key] = options[key];
      }
    }

		if (typeof defaults.date == 'object') {
			defaults.date = Math.round(defaults.date.getTime()/1000);
		}

    if (device.platform.toLowerCase() == 'android') {
      defaults.date = (options.date.getMonth()) + "/" + (options.date.getDate()) + "/"
					+ (options.date.getFullYear()) + "/" + (options.date.getHours()) + "/"
					+ (options.date.getMinutes());
    }

    cordova.exec(null,null,"LocalNotification","addNotification",[defaults]);
	};

	/**
	 * Cancel an existing notification using its original ID.
	 * 
	 * @param id
	 *            The ID that was used when creating the notification using the
	 *            'add' method.
	 */
	LocalNotification.cancel = function(id) {
    if (device.platform.toLowerCase() == 'android') {
      id = new Array({ id : id });
    }
		cordova.exec(null, null, "LocalNotification", "cancelNotification", id);
	};
	
	/**
	 * Cancel all notifications that were created by your application.
	 */
	LocalNotification.cancelAll = function(id) {
    cordova.exec(null, null, "LocalNotification", "cancelAllNotifications", []);
    
  };

  cordova.addConstructor(function () {
    if (!window.plugins) {
      window.plugins = {};
    }
    window.plugins.localNotification = LocalNotification;
  });

  return LocalNotification;

})(window.cordova || window.Cordova || window.PhoneGap);
