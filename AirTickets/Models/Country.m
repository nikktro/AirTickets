//
//  Country.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 23.11.2020.
//

#import "Country.h"

@implementation Country

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.currency = dictionary[@"currency"];
        self.translations = dictionary[@"name_translations"];
        self.name = dictionary[@"name"];
        self.code = dictionary[@"code"];
    }
    return self;
}

@end
