//
//  LocalNotification.m
//  Phonegap LocalNotification Plugin
//  Copyright (c) Greg Allen 2011 & 2012 Drew Dahlman
//  MIT Licensed

#import "LocalNotification.h"
#import <Cordova/CDV.h>

@implementation LocalNotification
- (void)addNotification:(CDVInvokedUrlCommand*)command {
    NSMutableDictionary *repeatDict = [[NSMutableDictionary alloc] init];
    [repeatDict setObject:[NSNumber numberWithInt:NSDayCalendarUnit] forKey:@"daily"];
    [repeatDict setObject:[NSNumber numberWithInt:NSWeekCalendarUnit] forKey:@"weekly"];
    [repeatDict setObject:[NSNumber numberWithInt:NSMonthCalendarUnit] forKey:@"monthly"];
    [repeatDict setObject:[NSNumber numberWithInt:NSYearCalendarUnit] forKey:@"yearly"];
    [repeatDict setObject:[NSNumber numberWithInt:0] forKey:@""];

  // ios8 Ask for permission to set a notification http://stackoverflow.com/q/24100313/1691
  if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
      [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
  }
    // notif settings
  NSMutableDictionary *options = (NSMutableDictionary*)[command.arguments objectAtIndex: 0];
  double timestamp = [[options objectForKey:@"date"] doubleValue];
  NSString *msg = [options objectForKey:@"message"];
  NSString *action = [options objectForKey:@"action"];
  NSString *notificationId = [options objectForKey:@"id"];
    NSString *sound = [options objectForKey:@"sound"];
    NSString *bg = [options objectForKey:@"background"];
    NSString *fg = [options objectForKey:@"foreground"];
    NSString *repeat = [options objectForKey:@"repeat"];
  NSInteger badge = [[options objectForKey:@"badge"] intValue];
  bool hasAction = ([[options objectForKey:@"hasAction"] intValue] == 1)?YES:NO;
  
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
  
  UILocalNotification *notif = [[UILocalNotification alloc] init];
  notif.fireDate = date;
  notif.hasAction = hasAction;
  notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.repeatInterval = [[repeatDict objectForKey: repeat] intValue];
  
  notif.alertBody = ([msg isEqualToString:@""])?nil:msg;
  notif.alertAction = action;
    
    notif.soundName = sound;
    notif.applicationIconBadgeNumber = badge;
  
  NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:notificationId,@"notificationId",bg,@"background",fg,@"foreground",nil];
    
    notif.userInfo = userDict;
  
  [[UIApplication sharedApplication] scheduleLocalNotification:notif];
  NSLog(@"Notification Set: %@ (ID: %@, Badge: %i, sound: %@,background: %@, foreground: %@)", date, notificationId, badge, sound,bg,fg);
  //[notif release];
  CDVPluginResult * pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)cancelNotification:(CDVInvokedUrlCommand*)command {
  NSString *notificationId = [command.arguments objectAtIndex:0];
  NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
  for (UILocalNotification *notification in notifications) {
    NSString *notId = [notification.userInfo objectForKey:@"notificationId"];
    if ([notificationId isEqualToString:notId]) {
      NSLog(@"Notification Canceled: %@", notificationId);
      [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
  }
}

- (void)cancelAllNotifications:(CDVInvokedUrlCommand*)command {
  NSLog(@"All Notifications cancelled");
  [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



@end
