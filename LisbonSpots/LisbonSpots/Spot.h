//
//  Spot.h
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface Spot : NSManagedObject <MKAnnotation>

@property (nonatomic) int32_t identifier;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;


//Construtor que cria um spot no Coredata, recebendo um JSONDict como argumento
+(instancetype)spotWithJSONDict:(NSDictionary *)JSONDict;

//Métodos que devolvem instâncias de Spot
+(NSArray *)fetchAllSpots;
+(NSArray *)fetchAllSpotsWithType:(NSString *)type;

@end
