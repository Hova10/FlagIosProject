//
//  Spot.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "Spot.h"
#import "AppDelegate.h"


@implementation Spot

@dynamic identifier;
@dynamic type;
@dynamic name;
@dynamic phone;
@dynamic desc;
@dynamic latitude;
@dynamic longitude;

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize km = _km;

+(instancetype)spotWithJSONDict:(NSDictionary *)JSONDict {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;

    
    // Verificar se já está guardado
    NSArray * array = [Spot fetchAllSpots];

    // Para cada spot já guardado
    for(Spot * spot in array)
    {
        // Ver se o identificador do novo já existe
        if(spot.identifier == [[JSONDict valueForKey:@"id"] intValue])
        {
            //Se existir retornar o antigo.
            // fazer set do titulo e subtitulo para aparecer no mapa
            [spot setTitle:spot.name subtitle:@"??? km"];
            return spot;
        }
    }
    
    Spot *newSpot = [NSEntityDescription insertNewObjectForEntityForName:@"Spot" inManagedObjectContext:moc];
    
    if (newSpot != nil) {
        //Ler do JSONDict e adicionar às Ivars de newSpot
        newSpot.identifier = [[JSONDict valueForKey:@"id"] intValue];
        newSpot.type = [JSONDict valueForKey:@"type"];
        newSpot.name = [JSONDict valueForKey:@"name"];
        newSpot.phone = [JSONDict valueForKey:@"phone"];
        newSpot.desc = [JSONDict valueForKey:@"desc"];
        newSpot.latitude = [[JSONDict valueForKey:@"latitude"] doubleValue];
        newSpot.longitude = [[JSONDict valueForKey:@"longitude"] doubleValue];
        
        // fazer set do titulo e subtitulo para aparecer no mapa
        [newSpot setTitle:newSpot.name subtitle:@"??? km"];
    }
    //Forçar o sync com o Coredata
    [appDelegate saveContext];
    return newSpot;
}

-(void)setDistance:(float)latitude longitude:(float)longitude
{
    //http://stackoverflow.com/questions/9108208/fastest-way-to-calculate-the-distance-between-two-cgpoints

    //http://stackoverflow.com/questions/1253499/simple-calculations-for-working-with-lat-lon-km-distance
    
    float latitudeParaKm = 110.54f;
    
    float dx = (self.longitude-longitude) * latitudeParaKm ; // (latitude * latitudeParaKm /1
    
    float longitudeParaKm = 111.320*cos(dx);

    float dy = (self.latitude-latitude) * longitudeParaKm; // (longitude * longitudeParaKm /1

    
    float dist = sqrt(dx*dx + dy*dy);
    
    _subtitle = [NSString stringWithFormat:@"%f km", dist];
    _km = dist;
}

+(NSArray *)fetchAllSpots {
    return [Spot fetchAllSpotsWithType:nil];
}

// Getter para coordinate
-(CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

-(void)setTitle:(NSString*)title subtitle:(NSString*)subtitle
{
    _title = title;
    _subtitle = subtitle;
}


// Pede todas as Annotations já existentes no Coredata
+(NSArray *)allAnnotations
{
    return [Spot fetchAllSpots];
}

// Construtor de Conveniência
+(instancetype)annotationWithCoord:(CLLocationCoordinate2D)coord
                           andName:(NSString *)name
{
    return nil;
}

+(NSArray *)fetchAllSpotsWithType:(NSString *)type {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = appDelegate.managedObjectContext;
    
    //criar o fetch request para a entity Spot
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Spot"];
    
    //Filtrar por type
    if (type != nil) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", type];
        
        [fetch setPredicate:predicate];
    }
    
    //executar o fetch
    NSError *err;
    NSArray *results = [moc executeFetchRequest:fetch error:&err];
    
    //Verificar se existiu erro
    if (err != nil) {
        return nil;
    }
    
    return results;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%d] - %@", self.identifier, self.name];
}

@end
