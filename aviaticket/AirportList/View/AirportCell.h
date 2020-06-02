//
//  AirportCell.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Airport.h"

NS_ASSUME_NONNULL_BEGIN

@interface AirportCell : UITableViewCell

@property (nonatomic, strong) UILabel *airportName;
@property (nonatomic, strong) UILabel *airportCode;

- (void)configureUI;
- (void)configureWith:(Airport *)airport;

@end

NS_ASSUME_NONNULL_END
