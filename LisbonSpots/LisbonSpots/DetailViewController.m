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
@property (weak, nonatomic) IBOutlet UITextView *kmBox;

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
        
        NSString * subtitle = _spot.subtitle;
        
        //            http://stackoverflow.com/questions/560517/make-a-float-only-show-two-decimal-places
        

        NSNumber *numberValue = [NSNumber numberWithFloat:_spot.km];
        
        if (numberValue && ![subtitle isEqualToString:@"??? km"]) {
            NSString *formatString = [NSString stringWithFormat:@"%%.%ldf km", (long)2];
            subtitle =  [NSString stringWithFormat:formatString, numberValue.floatValue];
        }
        
        self.kmBox.text = subtitle;
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
