//
//  EnteredGeofenceDetector.m
//  Sense360StarterObjC
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "EnteredGeofenceDetector.h"
#import "NotificationSender.h"
@import SenseSdk;

@implementation EnteredGeofenceDetector
- (void)geofenceDetectionStart {
    SenseSdkErrorPointer *errorPtr = [SenseSdkErrorPointer create];
    
    // Fire when the user enters a geofence
    CustomGeofence *hq = [[CustomGeofence alloc] initWithLatitude:37.124 longitude:-127.456 radius:50 customIdentifier:@"Sense 360 Headquarters"];
    NSArray *geofences = [[NSArray alloc] initWithObjects:hq,nil];
    Trigger *geofenceTrigger = [FireTrigger whenEntersGeofences:@"ArrivedAtGeofence" geofences:geofences conditions:nil errorPtr:nil];
    
    if(geofenceTrigger != nil) {
        // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" within the EnteredGeofenceDetector class
        EnteredGeofenceDetector *callback = [EnteredGeofenceDetector alloc];
        [SenseSdk registerWithTrigger:geofenceTrigger delegate:callback errorPtr:errorPtr];
    }
}

- (void)triggerFired:(TriggerFiredArgs*) args {
    
    // Your user has entered a geofence!
    
    for (NSObject <NSCoding, Place>* place in [args places]) {
        
        //This is where YOU write your custom code.
        //As an example, we are sending a local notification that describes the transition type and place.
        //For more information go to: http://sense360.com/docs.html#handling-a-recipe-firing
        NSString *transitionDesc;
        if(args.trigger.transitionType == TransitionTypeEnter) {
            transitionDesc = @"Enter";
        } else {
            transitionDesc = @"Exit";
        }
        CustomGeofence *geofence = (CustomGeofence*)place;
        NSString *notificationBody = [[NSString alloc] initWithFormat: @"%@ %@", transitionDesc, geofence.customIdentifier];
        [NotificationSender send:notificationBody];
    }
}
@end