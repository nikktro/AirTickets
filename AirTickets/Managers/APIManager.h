//
//  APIManager.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 29.11.2020.
//

#import <Foundation/Foundation.h>
#import "SearchRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class City;

@interface APIManager : NSObject

+ (instancetype)sharedInstance;

- (void)cityForCurrentIP:(void (^)(City *city))completion;

- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;

NSString *SearchRequestQuery(SearchRequest request);

@end

NS_ASSUME_NONNULL_END
