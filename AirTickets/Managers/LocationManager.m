//
//  LocationManager.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 08.12.2020.
//

#import <UIKit/UIKit.h> // !!!! Manager with UIKit for Alert controller
#import "LocationManager.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.locationManager.distanceFilter = 500; // 500 meters in case Kilometer accuracy
        [self.locationManager requestWhenInUseAuthorization];
    }
    return self;
}

- (void)dealloc {
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    switch (manager.authorizationStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
            
        case kCLAuthorizationStatusNotDetermined:
            break;
            
        default: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Can't get your location" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            UIViewController *rootVC = [[UIApplication sharedApplication].windows firstObject].rootViewController;
            [rootVC presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    if (location) {
        _currentLocation = location;
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerDidUpdateLocation object:location];
    }
}

@end
