//
//  PlaceViewController.h
//  AirTickets
//
//  Created by Nikolay Trofimov on 28.11.2020.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol PlaceViewControllerDelegate

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;

@end

@interface PlaceViewController : UITableViewController

@property (nonatomic, weak) id<PlaceViewControllerDelegate>delegate; //not strong

- (instancetype)initWithType:(PlaceType)type;


@end

NS_ASSUME_NONNULL_END
