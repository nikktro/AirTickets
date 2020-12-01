//
//  DataManager.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 23.11.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Airport, City, Country;

#define kDataManagerDidLoadData @"DataManagerDidLoadData"

typedef enum {
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSArray <Country *> *countries;
@property (nonatomic, strong, readonly) NSArray <City *> *cities;
@property (nonatomic, strong, readonly) NSArray <Airport *> *airports;

+ (instancetype)sharedInstance;

- (void)loadData;
- (City *)cityForIATA:(NSString *)iata;

@end

NS_ASSUME_NONNULL_END
