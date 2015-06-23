//
//  EnteredHomeDetector.h
//  Sense360StarterObjC
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SenseSdk;

@interface EnteredHomeDetector : NSObject<RecipeFiredDelegate>
- (void)homeDetectionStart;
@end
