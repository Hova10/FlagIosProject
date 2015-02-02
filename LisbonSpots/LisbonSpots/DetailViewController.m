//
//  DetailViewController.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 02/02/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Atribuir nome do spot
    if(_spot != nil)
    {
        self.titleBar.title = _spot.name;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
