//
//  CountryListController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CityListController.h"
#import "CountryListController.h"
#import "CountryListView.h"
#import "CountryListViewCell.h"
#import "DataManager.h"

@interface CountryListController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> ()

@end

@implementation CountryListController

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[CountryListView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Страны";
    
    // Закастим вью как CountryListView
    CountryListView *view = (CountryListView *)self.view;
    
    // Объявим делегата и датасурс у тэйблвью
    self.tableView = view.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Объявляем делегат для поиска
    self.searchController = view.searchController;
    self.searchController.searchBar.delegate = self;
    
    // Регистрируем класс для отображения ячейки
    [self.tableView registerClass:CountryListViewCell.self forCellReuseIdentifier:@"countryViewCell"];
    
    // Загружаем данные
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete:) name:kDataManagerLoadDataDidComplete object:nil];
    [[DataManager sharedInstance] loadData];
    
}

- (void)loadDataComplete:(NSNotification *)notification {
    self.view.backgroundColor = [UIColor greenColor];
    self.countries = [NSMutableArray arrayWithArray:[DataManager sharedInstance].countries];
    [self.tableView reloadData];
}

// MARK: TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.countries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryListViewCell *cell = (CountryListViewCell *) [self.tableView dequeueReusableCellWithIdentifier:@"countryViewCell"];
    
    Country *country = [self.countries objectAtIndex:indexPath.row];
    
    [cell configureWith:country];
    
    return cell;
}

// MARK: TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Ищем выбранную страну
    Country *selCountry = [self.countries objectAtIndex:indexPath.row];
    
    if (selCountry != nil) {
        UIViewController *cityController = (CityListController *) [[CityListController alloc] initWithCountry:selCountry];
        [self.navigationController pushViewController:cityController animated:true];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.countries = [NSMutableArray arrayWithArray:[DataManager sharedInstance].countries];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar) {
        // Если текстовое поле пустое значит надо вывести первоначальный список стран
        if ([searchBar.text length] > 0) {
            NSArray *testCountries = [DataManager sharedInstance].countries;
            [self.countries removeAllObjects];
            
            for (NSUInteger i = 0; i < [testCountries count]; i++) {
                Country *testCountry = [testCountries objectAtIndex:i];
                
                if ([testCountry.code compare:searchBar.text options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                    [self.countries addObject:testCountry];
                }
            }
        } else {
            self.countries = [NSMutableArray arrayWithArray:[DataManager sharedInstance].countries];
        }
        
        [self.tableView reloadData];
    }
}

@end
