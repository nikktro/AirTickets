//
//  TicketTableViewCell.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 01.12.2020.
//

#import <UIKit/UIKit.h>

#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
