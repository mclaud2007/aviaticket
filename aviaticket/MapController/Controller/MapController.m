//
//  MapController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 15.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "MapController.h"
#import "MapView.h"

@interface MapController ()

@end

@implementation MapController

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[MapView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Кастим вью и связываем ui элементы
    MapView *mapView = (MapView *)self.view;
    self.lblCountryName = mapView.lblCountryName;
    self.mkMapView = mapView.mapView;
    self.lblCityName = mapView.lblCityName;
    
    // Ищем координату текущего города
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.city.coordinate.latitude longitude:self.city.coordinate.longitude];
    
    // Попробуем найти название страны по координатам города
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0) {
            self.lblCountryName.text = [placemarks firstObject].country;
        }
    }];
   
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.city.coordinate.latitude, self.city.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 50000, 50000);
    
    if ([_airports count] > 0) {
        NSMutableArray *annotations = [NSMutableArray array];
        
        for (Airport *airport in _airports) {
            CLLocationCoordinate2D airportCoord = CLLocationCoordinate2DMake(airport.coordinate.latitude, airport.coordinate.longitude);
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = airport.code;
            annotation.subtitle = airport.name;
            annotation.coordinate = airportCoord;
            [annotations addObject:annotation];
        }
        
         [self.mkMapView addAnnotations:annotations];
    }
    
    [self.mkMapView setRegion:region animated:YES];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = self.city.name;
    self.lblCityName.text = self.title;
}

@end
