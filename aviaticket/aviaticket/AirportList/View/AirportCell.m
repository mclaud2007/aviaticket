//
//  AirportCell.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "AirportCell.h"

@implementation AirportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configureUI];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.airportName.text = @"";
    self.airportCode.text = @"";
}

- (void)configureWith:(Airport *)airport {
    self.airportName.text = airport.name;
    self.airportCode.text = airport.code;
}

- (void)configureUI {
    self.airportName = [[UILabel alloc] init];
    self.airportName.translatesAutoresizingMaskIntoConstraints = false;
    self.airportName.font = [UIFont systemFontOfSize:17];
    self.airportName.textColor = [UIColor blueColor];
    [self addSubview:self.airportName];
    
    self.airportCode = [[UILabel alloc] init];
    self.airportCode.translatesAutoresizingMaskIntoConstraints = false;
    self.airportCode.font = [UIFont systemFontOfSize:12];
    self.airportCode.textColor = [UIColor grayColor];
    [self addSubview:self.airportCode];
    
    // CellConstraint
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    // CountryNameConstraint
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *topCountryNameConstraint = [NSLayoutConstraint constraintWithItem:self.airportName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
    NSLayoutConstraint *leftCountryNameConstraint = [NSLayoutConstraint constraintWithItem:self.airportName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    NSLayoutConstraint *rightCountryNameConstraint = [NSLayoutConstraint constraintWithItem:self.airportName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
    
    // CountryCodeConstraint
    NSLayoutConstraint *topCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.airportCode attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.airportName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5];
    NSLayoutConstraint *leftCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.airportCode attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.airportName attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.airportCode attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.airportName attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomCountryCodeConstraint = [NSLayoutConstraint constraintWithItem:self.airportCode attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    
    // Массив контсрейнтов
    NSArray *constraints = [NSArray arrayWithObjects:topConstraint, leftConstraint, bottomConstraint, topCountryNameConstraint, leftCountryNameConstraint, rightCountryNameConstraint, bottomCountryCodeConstraint, topCountryCodeConstraint, leftCountryCodeConstraint, rightCountryCodeConstraint, nil];
    
    // Активируем констрейнты
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
