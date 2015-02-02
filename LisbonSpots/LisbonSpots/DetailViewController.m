//
//  DetailViewController.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 02/02/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "DetailViewController.h"

#import <AddressBook/AddressBook.h>

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (weak, nonatomic) IBOutlet UITextView *descBox;
@property (weak, nonatomic) IBOutlet UITextView *phoneBox;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Atribuir nome do spot
    if(_spot != nil)
    {
        self.titleBar.title = _spot.name;
        self.descBox.text = _spot.desc;
        self.phoneBox.text = _spot.phone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (IBAction)addContact:(id)sender {


}

@end
