//
//  AirportListController.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Airport.h"
#import "Country.h"
#import "City.h"
#import "DataManager.h"
#import "AirportListView.h"
#import "AirportCell.h"
#import "NotificationCenter.h"

#import "MapController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AirportListController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, nonnull) UITableView *tableView;
@property (nonatomic, strong) Country *selectedCountry;
@property (nonatomic, strong) City *selectedCity;
@property (nonatomic, strong) NSMutableArray *airports;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

- (instancetype) initWithCity:(City *) city AndCountry:(Country *)country;

@end

NS_ASSUME_NONNULL_END
