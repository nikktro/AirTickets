//
//  SearchRequest.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 28.11.2020.
//

#import <Foundation/Foundation.h>

typedef struct {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destination;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;

