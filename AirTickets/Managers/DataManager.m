//
//  DataManager.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 23.11.2020.
//

#import "DataManager.h"
#import "City.h"
#import "Country.h"
#import "Airport.h"

@implementation DataManager

+ (instancetype)sharedInstance {
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DataManager new];
    });
    return instance;
}

- (void)loadData {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSArray *countriesJson = [self arrayFromFileName:@"countries" ofType:@"json"];
        self->_countries = [self createObjectsFromArray:countriesJson withType:(DataSourceTypeCountry)];
        
        NSArray *citiesJson = [self arrayFromFileName:@"cities" ofType:@"json"];
        self->_cities = [self createObjectsFromArray:citiesJson withType:(DataSourceTypeCity)];
        
        NSArray *airportsJson = [self arrayFromFileName:@"airports" ofType:@"json"];
        self->_airports = [self createObjectsFromArray:airportsJson withType:(DataSourceTypeAirport)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerDidLoadData object:nil];
        });
        NSLog(@"Data load complete");
    });
}

- (City *)cityForIATA:(NSString *)iata {
    if (iata) {
        for (City *city in self.cities) {
            if ([city.code isEqualToString:iata]) {
                return city;
            }
        }
    }
    return nil;
}

- (NSArray *)arrayFromFileName:(NSString *)fileName ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array withType:(DataSourceType)type {
    NSMutableArray *results = [NSMutableArray new];
    
    for (NSDictionary *jsonObject in array) {
        switch (type) {
            case DataSourceTypeCountry: {
                Country *country = [[Country alloc] initWithDictionary: jsonObject];
                [results addObject: country];
                break;
            }
            case DataSourceTypeCity: {
                City *city = [[City alloc] initWithDictionary: jsonObject];
                [results addObject: city];
                break;
            }
            case DataSourceTypeAirport: {
                Airport *airport = [[Airport alloc] initWithDictionary: jsonObject];
                [results addObject: airport];
                break;
            }
        }
    }
    
    return results;
}


@end
