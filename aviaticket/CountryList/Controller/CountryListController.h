//
//  CountryListController.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryListView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryListController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> : UIViewController

@property UITableView *tableView;
@property UISearchController *searchController;
@property NSMutableArray *countries;

@end

NS_ASSUME_NONNULL_END
