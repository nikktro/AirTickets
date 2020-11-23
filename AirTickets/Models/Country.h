//
//  Country.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 23.11.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, strong) NSDictionary *translations;
@property (nonatomic, copy) NSString *code;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
