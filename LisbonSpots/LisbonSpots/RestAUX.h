//
//  RestAUX.h
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestAUX : NSObject

//Método que devolve o URL do JSON
+(NSURL *) spotsURL;

//Método que faz GET/Parse ao JSON e insere no CoreData
+(BOOL) getSpots;

@end
