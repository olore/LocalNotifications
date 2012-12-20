# LocalNotifications

This plugin hooks into the Local Notification API, allowing you to create & cancel notifications for users of your app.

The goals of this project are to unify iOS & Android implementations and support the [Cordova Plugin spec](https://github.com/alunny/cordova-plugin-spec), so that it works with [Pluginstall](https://github.com/alunny/pluginstall).


# Android
* Install via _pluginstall_
* Modify AlarmReceiver.java to import to your R class (modify the package name)
* Include LocalNotification.js in index.html
* Start using window.plugins.localnotification

# iOS
* Install via _pluginstall_
* Include LocalNotification.js in index.html
* Add the following code to AppDelegate.m

    - (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification 
    {

        UIApplicationState state = [application applicationState];
        if (state == UIApplicationStateActive) {
            // WAS RUNNING
            NSLog(@"I was currently active");

            NSString *notCB = [notification.userInfo objectForKey:@"foreground"];
            NSString *notID = [notification.userInfo objectForKey:@"notificationId"];

            NSString * jsCallBack = [NSString 
                                     stringWithFormat:@"%@(%@)", notCB,notID];  


            [self.viewController.webView  stringByEvaluatingJavaScriptFromString:jsCallBack];

            application.applicationIconBadgeNumber = 0;
        }
        else {
            // WAS IN BG
            NSLog(@"I was in the background");

            NSString *notCB = [notification.userInfo objectForKey:@"background"];
            NSString *notID = [notification.userInfo objectForKey:@"notificationId"];

            NSString * jsCallBack = [NSString 
                                     stringWithFormat:@"%@(%@)", notCB,notID]; 
            [self.viewController.webView stringByEvaluatingJavaScriptFromString:jsCallBack];         

            application.applicationIconBadgeNumber = 0;
        }                 
    }
* Start using window.plugins.localnotification

# Information
Originally forked from https://github.com/phonegap/phonegap-plugins

Repo format based on http://shazronatadobe.wordpress.com/2012/11/07/cordova-plugins-put-them-in-your-own-repo-2/


# To do
* Update instructions for installation (without [pluginstall](https://github.com/alunny/pluginstall))
* Create examples (unified Andoid & iOS examples)
* Update to latest Cordova plugin code for [Android](http://docs.phonegap.com/en/edge/guide_plugin-development_android_index.md.html#Developing%20a%20Plugin%20on%20Android) and [iOS](http://docs.phonegap.com/en/edge/guide_plugin-development_ios_index.md.html#Developing%20a%20Plugin%20on%20iOS)

# Credits
All the hard work on these plugins was done by Drew & Daniel.
I've merely collected them here and attempted to unify them.
* Android: https://github.com/dvtoever
* iOS: https://github.com/DrewDahlman
