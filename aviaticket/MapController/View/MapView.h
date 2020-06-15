//
//  MapView.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 15.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapView : UIView

@property (nonatomic, strong, nonnull) UILabel *lblCountryName;
@property (nonatomic, strong, nonnull) MKMapView *mapView;
@property (nonatomic, strong, nonnull) UILabel *lblCityName;

@end

NS_ASSUME_NONNULL_END
