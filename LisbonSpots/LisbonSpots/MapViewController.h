//
//  MapViewController.h
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//


#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Spot.h"


@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

