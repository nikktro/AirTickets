//
//  ViewController.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 17.11.2020.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "PlaceViewController.h"
#import "SearchRequest.h"
#import "City.h"
#import "Airport.h"


@interface MainViewController () <PlaceViewControllerDelegate>

@property (nonatomic, weak) UIButton *departureButton;
@property (nonatomic, weak) UIButton *arrivalButton;
@property (nonatomic, assign) SearchRequest searchRequest;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Search";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoadData:) name:kDataManagerDidLoadData object:nil];
    
    [[DataManager sharedInstance] loadData];
}

-(void)viewWillLayoutSubviews {
    UIButton *depart = [UIButton buttonWithType:UIButtonTypeSystem];
    [depart addTarget:self action:@selector(didTapPlaceButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [depart setTitle:@"From" forState:UIControlStateNormal];
    depart.tintColor = [UIColor blackColor];
    depart.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    depart.frame = CGRectMake(30.0, 140.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    [self.view addSubview:depart];
    self.departureButton = depart;
    
    UIButton *arrival = [UIButton buttonWithType:UIButtonTypeSystem];
    [arrival addTarget:self action:@selector(didTapPlaceButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [arrival setTitle:@"To" forState:UIControlStateNormal];
    arrival.tintColor = [UIColor blackColor];
    arrival.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    arrival.frame = CGRectMake(30.0, CGRectGetMaxY(depart.frame) + 20.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    [self.view addSubview:arrival];
    self.arrivalButton = arrival;
}

- (void)didLoadData:(NSNotification *)notification {
    //self.view.backgroundColor = [UIColor yellowColor];
    //NSLog(@"Data did loaded, notification %@", notification.name);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    [self selectPlace:place withType:placeType andDataType:dataType forButton:(placeType == PlaceTypeDeparture) ? self.departureButton : self.arrivalButton];
}

- (void)didTapPlaceButton:(UIButton *)sender {
    PlaceViewController *placeVC = [[PlaceViewController alloc] initWithType:[sender isEqual:self.departureButton] ? PlaceTypeDeparture : PlaceTypeArrival];
    placeVC.delegate = self;
    [self.navigationController pushViewController:placeVC animated:YES];
    
}

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType forButton:(UIButton *)button {
    NSString *title;
    NSString *iata;
    switch(dataType) {
        case DataSourceTypeCountry:
            break;
        case DataSourceTypeCity: {
            City *city = (City *)place;
            title = city.name;
            iata = city.code;
        }
        case DataSourceTypeAirport:{
            Airport *airport = (Airport *)place;
            title = airport.name;
            iata = airport.code;
        }
    }
    
    switch (placeType) {
        case PlaceTypeArrival:
            _searchRequest.destination = iata;
            break;
        case PlaceTypeDeparture:
            _searchRequest.origin = iata;
            break;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    
}


@end
