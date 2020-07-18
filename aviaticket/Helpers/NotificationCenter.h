//
//  NotificationCenter.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 05.07.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct Notification {
    __unsafe_unretained NSString * _Nullable title;
    __unsafe_unretained NSString * _Nonnull body;
    __unsafe_unretained NSDate * _Nonnull date;
    __unsafe_unretained NSURL * _Nonnull imageURL;
} Notification;

@interface NotificationCenter : NSObject <UNUserNotificationCenterDelegate>

+ (instancetype _Nonnull)shared;

- (void)registerService;
- (void)sendNotification:(Notification)notification;

Notification NotificationMake(NSString * _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date, NSURL * _Nullable imageURL);

@end

NS_ASSUME_NONNULL_END
