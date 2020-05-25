//
//  CountryListViewCell.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryListViewCell : UITableViewCell

@property UILabel *countryName;
@property UILabel *countryCode;

-(void)configureUI;
-(void)configureWith:(Country *)country;

@end

NS_ASSUME_NONNULL_END
