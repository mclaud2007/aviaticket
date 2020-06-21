//
//  CountryListController.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryListView.h"
#import "SearchResultControllerTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryListController: UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>

@property UITableView *tableView;
@property UISearchController *searchController;
@property (nonatomic, strong) SearchResultControllerTableViewController *resultViewController;
@property NSMutableArray *countries;

- (void)doSearch:(NSString *)query;

@end

NS_ASSUME_NONNULL_END
