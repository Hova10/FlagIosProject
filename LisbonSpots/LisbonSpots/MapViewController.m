//
//  MapViewController.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) CLLocationManager *locManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Instanciar o locManager
    _locManager = [[CLLocationManager alloc] init];

    // Pedir autorização para a localização (iOS 8)
    [_locManager requestAlwaysAuthorization];
    
    // Adicionar todas as Annotations ao mapa (vindas do CoreData)
    NSArray *allAnnotations = [Spot fetchAllSpots];
    [_map addAnnotations:allAnnotations];
    
}
- (IBAction)changeMapType:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            _map.mapType = MKMapTypeStandard;
            break;
        case 1:
            _map.mapType = MKMapTypeHybrid;
            break;
        case 2:
            _map.mapType = MKMapTypeSatellite;
            break;
    }
}

- (IBAction)zoomMap:(UISlider *)sender {
    
    
    float val = sender.value * 1000;
    MKCoordinateRegion region =MKCoordinateRegionMakeWithDistance(_map.centerCoordinate, val, val);
    
    [_map setRegion:region animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
