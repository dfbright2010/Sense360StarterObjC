//
//  NotificationSender.h
//  Sense360StarterObjC
//
//  Created by Sense360 on 6/25/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationSender : NSObject
+ (void)send:(NSString*) text;
@end