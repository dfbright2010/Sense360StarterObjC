//
//  EnteredHomeDetector.m
//  Sense360StarterObjC
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "EnteredHomeDetector.h"
#import "NotificationSender.h"
@import SenseSdk;

@implementation EnteredHomeDetector
- (void)homeDetectionStart {
    SenseSdkErrorPointer *errorPtr = [SenseSdkErrorPointer create];
    // Fire when the user enters home
    Trigger *homeTrigger = [FireTrigger whenEntersPoi:@"ArrivedAtHome" type:PoiTypeRestaurant conditions:nil errorPtr:errorPtr];
    
    if(homeTrigger != nil) {
        // Recipe defines what trigger, what time of day and how long to wait between consecutive triggers firing
        // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" within the EnteredHomeDetector class
        EnteredHomeDetector *callback = [EnteredHomeDetector alloc];
        [SenseSdk registerWithTrigger:homeTrigger delegate:callback errorPtr:errorPtr];
    }
}

- (void)triggerFired:(TriggerFiredArgs*) args {
    
    // Your user has entered home!
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
        PersonalizedPlace *personalizedPlace = (PersonalizedPlace*)place;
        NSString *personalizedPlaceType = [PersonalizedPlace getDescriptionOfPersonalizedPlaceType:(int)personalizedPlace.type];
        NSString *notificationBody = [[NSString alloc] initWithFormat: @"%@ %@", transitionDesc,personalizedPlaceType];
        [NotificationSender send:notificationBody];
    }
}
@end
