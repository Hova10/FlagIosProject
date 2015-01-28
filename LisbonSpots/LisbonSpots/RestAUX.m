//
//  RestAUX.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 28/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "RestAUX.h"
#import "Spot.h"

@implementation RestAUX

+ (NSURL *)spotsURL{
    return [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/3327071/LisbonSpots.json"];
}

+ (BOOL)getSpots{
    NSURL *url = [RestAUX spotsURL];
    
    //criar o request
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:url];
    
    //Executar o request
    NSHTTPURLResponse *httpResponse;
    NSError *err;
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&httpResponse error:&err];
    
    
    //Verificar se existiram erros na chamada http
    if (err != nil || (httpResponse.statusCode != 200)) {
        return NO;
    }
    
    NSArray *spotsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&err];
    
    //Verificar se existiram erros na desserialização JSON
    if (err!= nil) {
        return NO;
    }
    
    //Criar os spots no Coredata
    for (NSDictionary *dict in spotsArray) {
        [Spot spotWithJSONDict:dict];
    }
    
    return YES;
}

@end
