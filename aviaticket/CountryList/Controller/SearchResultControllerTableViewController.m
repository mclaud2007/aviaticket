//
//  SearchResultControllerTableViewController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 21.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "SearchResultControllerTableViewController.h"

@interface SearchResultControllerTableViewController ()

@end

@implementation SearchResultControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.definesPresentationContext = YES;
}

- (void)update {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultsCell"];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"resultsCell"];
    }
    
    Country *item = _results[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.code;
    cell.detailTextLabel.textColor = UIColor.lightGrayColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Ищем выбранную страну
    Country *selCountry = [self.results objectAtIndex:indexPath.row];
    NSLog(@"%@", selCountry);
    
    if (selCountry != nil) {
        UIViewController *cityController = (CityListController *) [[CityListController alloc] initWithCountry:selCountry];
        //[self.navigationController pushViewController:cityController animated:true];
        [self.parentViewController.presentingViewController.navigationController pushViewController:cityController animated:true];
        
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
