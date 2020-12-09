//
//  MapPrice.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 08.12.2020.
//

#import "MapPrice.h"
#import "DataManager.h"

@implementation MapPrice

- (instancetype)initWithDictionary:(NSDictionary *)dictionary withOrigin:(City *)origin {
    self = [super init];
    if (self) {
        self.destination = [[DataManager sharedInstance] cityForIATA: [dictionary valueForKey:@"destination"]];
        self.origin = origin;
        self.departure = [self dateFromString:[dictionary valueForKey:@"depart_date"]];
        self.returnDate = [self dateFromString:[dictionary valueForKey:@"return_date"]];
        self.numberOfChanges = [[dictionary valueForKey:@"number_of_changes"] integerValue];
        self.value = [[dictionary valueForKey:@"value"] integerValue];
        self.distance = [[dictionary valueForKey:@"distance"] integerValue];
        self.actual = [[dictionary valueForKey:@"actual"] boolValue];
    }
    return self;
}

- (NSDate * _Nullable)dateFromString:(NSString *)dateString {
    if (!dateString) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter dateFromString: dateString];
}

@end
