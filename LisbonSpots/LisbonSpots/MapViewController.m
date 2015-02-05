//
//  MapViewController.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locManager;
@property (weak, nonatomic) IBOutlet UISlider *zoomSlider;

@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Instanciar o locManager
    _locManager = [[CLLocationManager alloc] init];

    _locManager.delegate = self;
    // Pedir autorização para a localização (iOS 8)
    [_locManager requestAlwaysAuthorization];
    
    // Adicionar todas as Annotations ao mapa (vindas do CoreData)
    NSArray *allAnnotations = [Spot fetchAllSpots];
    [_map addAnnotations:allAnnotations];
    
    _map.delegate = self;
    
    float val = _map.region.span.latitudeDelta;
    [_zoomSlider setValue:val animated:YES];
    
}

//http://stackoverflow.com/questions/17402876/viewforannotation-didnt-get-called-ios-noob
- (MKAnnotationView *)mapView:(MKMapView *)myMap viewForAnnotation:(id < MKAnnotation >)annotation
{
    // Criar um novo contentor de imagem
    MKAnnotationView * av = [[MKAnnotationView alloc] init];
    
    // http://stackoverflow.com/questions/10751052/tapping-on-mkannotationview-doesnt-call-didselectannotationview-delegate
    // Tentei por a não e não deu nada, pus a sim e funcionou
    // Activar o popup de informação
    [av setCanShowCallout:YES];
    
    // ir buscar o spot

    
    //http://stackoverflow.com/questions/1144629/in-objective-c-how-do-i-test-the-object-type
    
    if([annotation isKindOfClass:[Spot class]])
    {
        Spot * spot = (Spot*)annotation;
        
    // http://stackoverflow.com/questions/6808792/change-uiimage-from-mkannotation-in-the-mkmapview
        // Mudar a imagem consoante o tipo
        if([spot.type isEqualToString:@"restaurant"])
            av.image = [UIImage imageNamed: @"back3.png"];
        else if([spot.type isEqualToString:@"club"])
            av.image = [UIImage imageNamed: @"back2.png"];
        else if([spot.type isEqualToString:@"bar"])
            av.image = [UIImage imageNamed: @"Back.png"];
    }
    else // imagem do utilizador
    {
        av.image = [UIImage imageNamed: @"location.png"];
    }
    return av;
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

- (IBAction)toggleLocation:(UISwitch *)sender {
    _map.showsUserLocation = sender.isOn;

}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_map.userLocation.coordinate, _zoomSlider.value, _zoomSlider.value);
    
    [_map setRegion:region animated:YES];
    
    // mudamos de posição actualizar todos os spots
    NSArray * spots = [Spot fetchAllSpots];
    
    for(Spot * spot in spots)
    {
        [spot setDistance:_map.userLocation.coordinate.latitude longitude:_map.userLocation.coordinate.longitude];
    }
    
}





@end
