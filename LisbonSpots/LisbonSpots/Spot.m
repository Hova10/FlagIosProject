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

    }
    //Forçar o sync com o Coredata
    [appDelegate saveContext];
    return newSpot;
}

+(NSArray *)fetchAllSpots {
    return [Spot fetchAllSpotsWithType:nil];
}

// Getter para coordinate
-(CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
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
