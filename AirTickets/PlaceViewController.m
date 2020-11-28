//
//  PlaceViewController.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 28.11.2020.
//

#import "PlaceViewController.h"
#import "City.h"
#import "Airport.h"

#define kReuseIdentifier @"CellIdentifier"

@interface PlaceViewController ()

@property (nonatomic, assign) PlaceType placeType; //assign
@property (nonatomic, weak) UISegmentedControl *segmentedControl;
@property (nonatomic, copy) NSArray *currentArray;

@end

@implementation PlaceViewController

- (instancetype)initWithType:(PlaceType)type {
    self = [super init];
    if (self) {
        self.placeType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier]; // forIndexPath:indexPath
    
    UISegmentedControl *segments = [[UISegmentedControl alloc] initWithItems:@[ @"Cities", @"Airports" ]];
    [segments addTarget:self action:@selector(changeSource:) forControlEvents:UIControlEventValueChanged];
    segments.tintColor = [UIColor blackColor];
    segments.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = segments;
    self.segmentedControl = segments;
    [self changeSource:segments];
    
    switch (self.placeType) {
        case PlaceTypeArrival:
            self.title = @"Arrival";
        case PlaceTypeDeparture:
            self.title = @"Departure";
    }
}

- (void)changeSource:(UISegmentedControl *)sender {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.currentArray = [[DataManager sharedInstance] cities];
            break;
        case 1:
            self.currentArray = [[DataManager sharedInstance] airports];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath]; //need register
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        City *city = self.currentArray[indexPath.row];
        cell.textLabel.text = city.name;
        cell.detailTextLabel.text = city.code;
    } else {
        Airport *airport = self.currentArray[indexPath.row];
        cell.textLabel.text = airport.name;
        cell.detailTextLabel.text = airport.code;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int) self.segmentedControl.selectedSegmentIndex + 1);
    [self.delegate selectPlace:self.currentArray[indexPath.row] withType:self.placeType andDataType:dataType];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
