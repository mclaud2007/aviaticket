//
//  CountryListView.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultControllerTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryListView : UIView

@property (nonatomic, strong, nonnull) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultControllerTableViewController *resultViewController;
@property (nonatomic, strong) UILabel *lblLoading;
@property (nonatomic, strong) UIView *loadingScreen;
- (void) configureUI;

@end

NS_ASSUME_NONNULL_END
