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
@property (weak, nonatomic) IBOutlet UIImageView *imageBox;

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
        
        // Calcular distancia
        NSNumber *numberValue = [NSNumber numberWithFloat:_spot.km];
        
        if (numberValue && ![subtitle isEqualToString:@"??? km"]) {
            NSString *formatString = [NSString stringWithFormat:@"%%.%ldf km", (long)2];
            subtitle =  [NSString stringWithFormat:formatString, numberValue.floatValue];
        }
        self.kmBox.text = subtitle;

        // Imagem aleatoria
        NSMutableArray * array = [NSMutableArray arrayWithObjects:@"rest.png",@"Back.png", nil];
        
        // ir buscar um num aleatorio
        int randIndex = rand() % [array count];
        
        // aceder ao elemento do array e atribuir imagem
        self.imageBox.image = [UIImage imageNamed:[array objectAtIndex:randIndex]];
        
        
        
        
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

// http://www.ioscreator.com/tutorials/add-contacts-to-the-address-book-in-ios7
- (IBAction)addContact:(id)sender {

    ABAddressBookRef addressBook = NULL;
    CFErrorRef error = NULL;
    
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized: {
            addressBook = ABAddressBookCreateWithOptions(NULL, &error);
            
            [self addAccountWithSpot:_spot inAddressBook:addressBook];
            
            if (addressBook != NULL) CFRelease(addressBook);
            break;
        }
        case kABAuthorizationStatusDenied: {
            NSLog(@"Access denied to address book");
            break;
        }
        case kABAuthorizationStatusNotDetermined: {
            addressBook = ABAddressBookCreateWithOptions(NULL, &error);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    NSLog(@"Access was granted");
                    [self addAccountWithSpot:_spot inAddressBook:addressBook];
                }
                else NSLog(@"Access was not granted");
                if (addressBook != NULL) CFRelease(addressBook);
            });
            break;
        }
        case kABAuthorizationStatusRestricted: {
            NSLog(@"access restricted to address book");
            break;
        }
    }
}


    - (ABRecordRef)addAccountWithSpot:(Spot *)spot inAddressBook:(ABAddressBookRef)addressBook
    {
        ABRecordRef result = NULL;
        CFErrorRef error = NULL;
        
        //1
        result = ABPersonCreate();
        if (result == NULL) {
            NSLog(@"Failed to create a new person.");
            return NULL;
        }
        
        //2
        BOOL couldSetFirstName = ABRecordSetValue(result, kABPersonFirstNameProperty, (__bridge CFTypeRef)_spot.name, &error);

        
        // http://stackoverflow.com/questions/23188066/add-phone-numbers-to-abperson
        ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)_spot.phone, kABPersonPhoneMainLabel, NULL);
        
        BOOL couldSetLastName = ABRecordSetValue(result, kABPersonPhoneProperty, phoneNumbers, nil);
        
        if (couldSetFirstName && couldSetLastName) {
            NSLog(@"Successfully set the first name and the last name of the person.");
        } else {
            NSLog(@"Failed.");
        }
        
        //3
        BOOL couldAddPerson = ABAddressBookAddRecord(addressBook, result, &error);
        
        if (couldAddPerson) {
            NSLog(@"Successfully added the person.");
        } else {
            NSLog(@"Failed to add the person.");
            CFRelease(result);
            result = NULL;
            return result;
        }
        
        //4
        if (ABAddressBookHasUnsavedChanges(addressBook)) {
            BOOL couldSaveAddressBook = ABAddressBookSave(addressBook, &error);
            
            if (couldSaveAddressBook) {
                NSLog(@"Succesfully saved the address book.");
            } else {
                NSLog(@"Failed.");
            }
        }
        
        return result;
    }

@end
