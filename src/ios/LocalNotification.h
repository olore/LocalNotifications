//
//  LocalNotification.h
//	Phonegap LocalNotification Plugin
//	Copyright (c) Greg Allen 2011 & 2012 Drew Dahlman
//	MIT Licensed

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LocalNotification : CDVPlugin {
    
}
- (void)addNotification:(CDVInvokedUrlCommand*)arguments;
- (void)cancelNotification:(CDVInvokedUrlCommand*)arguments;
- (void)cancelAllNotifications:(CDVInvokedUrlCommand*)arguments;

@end
