//
//  TicketsTableViewController.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 01.12.2020.
//

#import "TicketsTableViewController.h"
#import "TicketTableViewCell.h"


@interface TicketsTableViewController ()

@property (nonatomic, strong) NSArray *tickets;

@end

@implementation TicketsTableViewController

- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self)
    {
        self.tickets = tickets;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Ticket";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:[TicketTableViewCell identifier]];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TicketTableViewCell identifier] forIndexPath:indexPath];
    cell.ticket = self.tickets[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

@end
