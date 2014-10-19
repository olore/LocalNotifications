# LocalNotifications

This plugin hooks into the Local Notification API, allowing you to create & cancel notifications for users of your app.

The goals of this project are to unify iOS & Android implementations and support the [Cordova Plugin spec](https://github.com/alunny/cordova-plugin-spec), so that it works with [Pluginstall](https://github.com/alunny/pluginstall).

Great post explaining [how to use pluginstall](http://blog.chariotsolutions.com/2012/11/installing-phonegap-plugins-with.html).

## Android
1. Install via _pluginstall_
2. Include LocalNotification.js in index.html
3. Ensure R.java contains a 'drawable' 'icon', since we use it here:
``` 
   int icon = res.getIdentifier("icon", "drawable", context.getPackageName());
```

4. Start using window.plugins.localnotification

## iOS
1. Install via _pluginstall_
2. Include LocalNotification.js in index.html
3. Add the following code to AppDelegate.m
```
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
```
4. Start using window.plugins.localnotification

## Information
Originally forked from https://github.com/phonegap/phonegap-plugins

Repo format based on http://shazronatadobe.wordpress.com/2012/11/07/cordova-plugins-put-them-in-your-own-repo-2/


## Credits
All the hard work on these plugins was done by Drew & Daniel.  
I've merely collected them here and attempted to unify them.  
* Android: https://github.com/dvtoever
* iOS: https://github.com/DrewDahlman
