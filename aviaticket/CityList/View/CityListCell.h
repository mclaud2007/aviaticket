//
//  CityListCell.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityListCell : UITableViewCell

@property (nonatomic, strong) UILabel *cityName;
@property (nonatomic, strong) UILabel *cityCode;

- (void)configureUI;
- (void)configureWith:(City *)city;

@end

NS_ASSUME_NONNULL_END
