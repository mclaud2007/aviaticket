//
//  CountryListView.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryListView : UIView

@property UITableView *tableView;
@property UISearchController *searchController;
- (void) configureUI;

@end

NS_ASSUME_NONNULL_END
