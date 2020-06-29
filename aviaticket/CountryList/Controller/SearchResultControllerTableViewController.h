//
//  SearchResultControllerTableViewController.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 21.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import "CityListController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultControllerTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *results;
- (void)update;
@end

NS_ASSUME_NONNULL_END
