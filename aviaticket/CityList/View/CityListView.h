//
//  CityListView.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityListView : UIView

@property UITableView *tableView;

- (void)configureUI;

@end

NS_ASSUME_NONNULL_END
