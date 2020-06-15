//
//  AirportListView.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirportListView : UIView

@property (nonatomic, strong, nonnull) UITableView *tableView;

- (void)configureUI;

@end

NS_ASSUME_NONNULL_END
