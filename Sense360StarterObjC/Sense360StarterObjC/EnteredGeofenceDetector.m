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
    Trigger *geofenceTrigger = [FireTrigger whenEntersGeofences: geofences conditions:nil errorPtr:nil];
    
    if(geofenceTrigger != nil) {
        // Recipe defines what trigger, what time of day and how long to wait between consecutive triggers firing
        Recipe *recipe = [[Recipe alloc] initWithName: @"ArrivedAtGeofence"
                                              trigger:geofenceTrigger
                          // Do NOT restrict the firing to a particular time of day
                                           timeWindow: [TimeWindow allDay]
                          // Wait at least 1 hour between consecutive triggers firing.
                                             cooldown: [Cooldown createWithOncePer:1 frequency:CooldownTimeUnitHours errorPtr:nil]];
        
        // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" within the EnteredGeofenceDetector class
        EnteredGeofenceDetector *callback = [EnteredGeofenceDetector alloc];
        [SenseSdk registerWithRecipe:recipe delegate:callback errorPtr:errorPtr];
    }
}

- (void)recipeFired:(RecipeFiredArgs*) args {
    
    // Your user has entered a geofence!
    
    for (TriggerFiredArgs* trigger in [args triggersFired]) {
        for (NSObject <NSCoding, Place>* place in [trigger places]) {
            
            //This is where YOU write your custom code.
            //As an example, we are sending a local notification that describes the transition type and place.
            //For more information go to: http://sense360.com/docs.html#handling-a-recipe-firing
            NSString *transitionDesc;
            if(args.recipe.trigger.transitionType == TransitionTypeEnter) {
                transitionDesc = @"Enter";
            } else {
                transitionDesc = @"Exit";
            }
            CustomGeofence *geofence = (CustomGeofence*)place;
            NSString *notificationBody = [[NSString alloc] initWithFormat: @"%@ %@", transitionDesc, geofence.customIdentifier];
            [NotificationSender send:notificationBody];
        }
    }
}
@end