//
//  TicketsTableViewController.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 01.12.2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TicketsTableViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;

@end

NS_ASSUME_NONNULL_END
