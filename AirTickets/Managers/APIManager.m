//
//  APIManager.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 29.11.2020.
//

#import "APIManager.h"
#import "DataManager.h"
#import "MapPrice.h"
#import "City.h"
#import "Ticket.h"

#define API_TOKEN @"73d98b96efbfeec4416e3e40e9c8ddbe"
#define API_URL_IP_ADDRESS @"https://api.ipify.org/?format=json"
#define API_URL_CITY_FROM_IP @"https://www.travelpayouts.com/whereami?ip="
#define API_URL_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"
#define API_URL_MAP_PRICE @"https://map.aviasales.ru/prices.json?origin_iata="

@implementation APIManager

+ (instancetype)sharedInstance {
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [APIManager new];
    });
    return instance;
}

- (void)cityForCurrentIP:(void (^)(City *city))completion {
    [self IPAddressWithCompletion:^(NSString *ipAddress) {
        NSString *url = [NSString stringWithFormat:@"%@%@", API_URL_CITY_FROM_IP, ipAddress];
        [self load:url withCompletion:^(id  _Nullable result) {
            City *city;
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json = (NSDictionary *)result;
                NSString *iata = json[@"iata"];
                if (iata) {
                    city = [[DataManager sharedInstance] cityForIATA:iata];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(city);
            });
            
        }];
    }];
}

- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion {
    NSString *url = [NSString stringWithFormat:@"%@?%@&token=%@", API_URL_CHEAP, SearchRequestQuery(request), API_TOKEN];
        [self load:url withCompletion:^(id  _Nullable result) {
            NSMutableArray *tickets;
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json = ((NSDictionary *)result)[@"data"][request.destination];
                tickets = [NSMutableArray new];
                for (NSString *key in json) {
                    NSDictionary *value = json[key];
                    Ticket *ticket = [[Ticket alloc] initWithDictionary:value];
                    ticket.from = request.origin;
                    ticket.to = request.destination;
                    [tickets addObject:ticket];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(tickets);
            });
        }];
}

- (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion {
    static BOOL isLoading;
    if (isLoading) return;
    isLoading = YES;
    
    NSString *url = [NSString stringWithFormat:@"%@%@", API_URL_MAP_PRICE, origin.code];
    [self load:url withCompletion:^(id  _Nullable result) {
        NSMutableArray *prices;
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = result;
            prices = [[NSMutableArray alloc] initWithCapacity:array.count];
            for (NSDictionary *dict in array) {
                MapPrice *price = [[MapPrice alloc] initWithDictionary:dict withOrigin:origin];
                [prices addObject:price];
            }
        }
        isLoading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(prices);
        });
    }];
}

- (void)IPAddressWithCompletion:(void (^)(NSString *ipAddress))completion {
    [self load:API_URL_IP_ADDRESS withCompletion:^(id  _Nullable result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json = (NSDictionary *)result;
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(json[@"ip"]);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
        }
    }];
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            completion(result);
        } else {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            }
            completion(nil);
        }
    }];
    [task resume];
}

NSString *SearchRequestQuery(SearchRequest request) {
    NSString *result = [NSString stringWithFormat:@"origin=%@&destination=%@",
                        request.origin,
                        request.destination];
    if (request.departDate && request.returnDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM";
        result = [result stringByAppendingFormat:@"&depart_date=%@&return_date=%@",
                  [dateFormatter stringFromDate:request.departDate],
                  [dateFormatter stringFromDate:request.returnDate]];
    }
    return result;
}



@end
