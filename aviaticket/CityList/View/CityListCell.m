//
//  CityListCell.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CityListCell.h"

@implementation CityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configureUI];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.cityName.text = @"";
    self.cityCode.text = @"";
}

- (void)configureWith:(City *)city {
    self.cityName.text = city.name;
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeID = [locale.localeIdentifier substringToIndex:2];
    NSDictionary *_translations = city.translations;
    
    if (localeID) {
        NSString *localeName = [_translations valueForKey:localeID];
        
        if (localeName) {
            self.cityName.text = localeName;
        }
    }
    
    self.cityCode.text = city.code;
}

- (void)configureUI {
    self.cityName = [[UILabel alloc] init];
    self.cityName.translatesAutoresizingMaskIntoConstraints = false;
    self.cityName.font = [UIFont systemFontOfSize:17];
    self.cityName.textColor = [UIColor blueColor];
    [self addSubview:self.cityName];
    
    self.cityCode = [[UILabel alloc] init];
    self.cityCode.translatesAutoresizingMaskIntoConstraints = false;
    self.cityCode.font = [UIFont systemFontOfSize:12];
    self.cityCode.textColor = [UIColor grayColor];
    [self addSubview:self.cityCode];
    
    // CellConstraint
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    // CountryNameConstraint
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *topCountryNameConstraint = [NSLayoutConstraint constraintWithItem:self.cityName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
    NSLayoutConstraint *leftCountryNameConstraint = [NSLayoutConstraint constraintWithItem:self.cityName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    NSLayoutConstraint *rightCountryNameConstraint = [NSLayoutConstraint constraintWithItem:self.cityName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
    
    // CountryCodeConstraint
    NSLayoutConstraint *topCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.cityCode attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cityName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5];
    NSLayoutConstraint *leftCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.cityCode attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.cityName attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.cityCode attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.cityName attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.cityCode attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    
    // Массив контсрейнтов
    NSArray *constraints = [NSArray arrayWithObjects:topConstraint, leftConstraint, bottomConstraint, topCountryNameConstraint, leftCountryNameConstraint, rightCountryNameConstraint, bottomCountryCodeConstraint, topCountryCodeConstraint, leftCountryCodeConstraint, rightCountryCodeConstraint, nil];
    
    // Активируем констрейнты
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
