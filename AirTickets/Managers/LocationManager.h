//
//  LocationManager.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 08.12.2020.
//

#import "CoreLocation/CoreLocation.h"

#define kLocationManagerDidUpdateLocation @"LocationManagerDidUpdateLocation"

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

@property (nonatomic, readonly) CLLocation *currentLocation;

@end

NS_ASSUME_NONNULL_END
