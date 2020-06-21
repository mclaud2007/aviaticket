//
//  MapView.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 15.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}



- (void)configureView {
    // Название города
    self.lblCountryName = [[UILabel alloc] init];
    self.lblCountryName.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.lblCountryName];
    
    // Карта
    self.mapView = [[MKMapView alloc] init];
    self.mapView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.mapView];
    
    // Почтовый адрес из геокодера
    self.lblCityName = [[UILabel alloc] init];
    self.lblCityName.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.lblCityName];
    
    NSLayoutConstraint *lblCountryNameConstraintCenterX = [NSLayoutConstraint constraintWithItem:self.lblCountryName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *lblCountryNameConstraintTop = [NSLayoutConstraint constraintWithItem:self.lblCountryName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *mapViewLeft = [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *mapRight = [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint *mapTop = [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblCountryName attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *lblPostalAdresTop = [NSLayoutConstraint constraintWithItem:self.lblCityName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mapView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *lblPostalAdresCenterX = [NSLayoutConstraint constraintWithItem:self.lblCityName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *lblPostalAdresBottom = [NSLayoutConstraint constraintWithItem:self.lblCityName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    
    NSArray *constraints = [NSArray arrayWithObjects:lblCountryNameConstraintTop, lblCountryNameConstraintCenterX, mapTop, mapViewLeft, mapRight, lblPostalAdresCenterX, lblPostalAdresTop, lblPostalAdresBottom, nil];
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
