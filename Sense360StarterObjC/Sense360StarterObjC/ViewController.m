//
//  ViewController.m
//  Sense360StarterObjC
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

#import "ViewController.h"
@import SenseSdk;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *restaurauntButton;

@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@property (weak, nonatomic) IBOutlet UIButton *geofenceButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)triggerRestauraunt:(UIButton *)sender {
    SenseSdkErrorPointer *errorPtr = [SenseSdkErrorPointer create];
    
    //Create a fake restaurant
    PoiPlace* poiPlace = [[PoiPlace alloc] initWithLatitude:34.111
                                                  longitude:-118.111
                                                     radius:50
                                                       name:@"Big Restaurant"
                                                         id:@"id1"
                                                       type: PoiTypeRestaurant];
    
    // This method should only be used for testing
    NSArray* places = [[NSArray alloc] initWithObjects:poiPlace, nil];
    [SenseSdkTestUtility fireTrigger:@"ArrivedAtRestaurant"
                               confidenceLevel:ConfidenceLevelMedium
                                        places:places
                                      errorPtr:errorPtr];
    if(errorPtr.error != nil) {
        NSLog(@"Error sending trigger");
    }

}

- (IBAction)triggerHome:(UIButton *)sender {
    SenseSdkErrorPointer *errorPtr = [SenseSdkErrorPointer create];
    
    //Create a fake home
    PersonalizedPlace* personalizedPlace = [[PersonalizedPlace alloc] initWithLatitude:34.111
                                                                             longitude:-118.111
                                                                                radius:50
                                                                 personalizedPlaceType: PersonalizedPlaceTypeHome];
    
    // This method should only be used for testing
    NSArray* places = [[NSArray alloc] initWithObjects:personalizedPlace, nil];
    [SenseSdkTestUtility fireTrigger:@"ArrivedAtHome"
                               confidenceLevel:ConfidenceLevelMedium
                                        places:places
                                      errorPtr:errorPtr];
    if(errorPtr.error != nil) {
        NSLog(@"Error sending trigger");
    }
}

- (IBAction)triggerGeofence:(UIButton *)sender {
    SenseSdkErrorPointer *errorPtr = [SenseSdkErrorPointer create];
    
    CustomGeofence *hq = [[CustomGeofence alloc] initWithLatitude:37.124 longitude:-127.456 radius:50 customIdentifier:@"Sense 360 Headquarters"];
    
    // This method should only be used for testing, and will test with the NSArray *geofences
    NSArray* places = [[NSArray alloc] initWithObjects:hq, nil];
    [SenseSdkTestUtility fireTrigger:@"ArrivedAtGeofence"
                               confidenceLevel:ConfidenceLevelMedium
                                        places:places
                                      errorPtr:errorPtr];
    if(errorPtr.error != nil) {
        NSLog(@"Error sending trigger");
    }
}

@end
