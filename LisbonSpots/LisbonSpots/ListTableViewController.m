//
//  ListTableViewController.m
//  LisbonSpots
//
//  Created by Bruno Capelo Feijão on 29/01/15.
//  Copyright (c) 2015 Bruno. All rights reserved.
//

#import "ListTableViewController.h"
#import "Spot.h"
#import "DetailViewController.h"

@interface ListTableViewController ()

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bares = [NSMutableArray array];
    _restaurantes = [NSMutableArray array];
    _clubes = [NSMutableArray array];
    
    // buscar todos os spots
    NSArray * spots = [Spot fetchAllSpots];
    
    // Para cada spot
    for(Spot * spot in spots)
    {
        
        // Adicionar se pertencer à secção

        if([spot.type isEqualToString:@"restaurant"])
            [_restaurantes addObject:spot];
        else if([spot.type isEqualToString:@"club"])
            [_clubes addObject:spot];
        else if([spot.type isEqualToString:@"bar"])
            [_bares addObject:spot];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    // vai buscar a secção e devolve o numero de elementos
    NSMutableArray * sectionArray  = [self getSection:section];
    if(sectionArray != nil)
        return [sectionArray count];
    return 0;
}

-(NSMutableArray*)getSection:(NSInteger)section
{
    // escolhe a secção correspondente
    switch (section) {
        case 0:
            return _restaurantes;
            break;
        case 1:
            return _bares;
            break;
        case 2:
            return _clubes;
            break;
        default:
            break;
    }
    return nil;
}

-(Spot*)getSpotAt:(NSIndexPath*)path
{
    // Ir buscar a secção
    NSMutableArray * section = [self getSection:path.section];

    // se existir a secção e tiver o elemento
    if(section != nil && path.row < [section count])
    {
        return (Spot*)[section objectAtIndex:path.row];
    }
    
    // se não
    return nil;
        
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Spot * spot = [self getSpotAt:indexPath];
    
    cell.textLabel.text = spot.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Restaurantes";
            break;
        case 1:
            return @"Bares";
            break;
        case 2:
            return @"Clubes";
            break;
        default:
            break;
    }
    return @"";

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    // Ir buscar próximo controlador e dar-lhe o Spot clicado
    DetailViewController *detailVC = [segue destinationViewController];
    
    // Ir buscar index seleccionado
    NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
    
    // Ir buscar e atribuir spot
    Spot * spot = [self getSpotAt:selectedIndex];
    detailVC.spot = spot;
}


@end
