//
//  City.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 23.11.2020.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface City : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *timezone;
@property (nonatomic, strong) NSDictionary *translations;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
