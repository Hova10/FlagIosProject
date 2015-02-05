//
//  ListTableViewController.h
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 29/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController
{
    // um array para cada tipo de spot
    NSMutableArray * _restaurantes; // secção 0
    NSMutableArray * _bares; // secção 1
    NSMutableArray * _clubes; // secção 2
}

-(IBAction)goBackToList:(UIStoryboardSegue *)sender;
@end
