//
//  ViewController.m
//  AirTickets
//
//  Created by Nikolay Trofimov on 17.11.2020.
//

#import "MainViewController.h"
#import "DataManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoadData:) name:kDataManagerDidLoadData object:nil];
    
    [[DataManager sharedInstance] loadData];
}

- (void)didLoadData:(NSNotification *)notification {
    self.view.backgroundColor = [UIColor yellowColor];
    //NSLog(@"Data did loaded, notification %@", notification.name);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
