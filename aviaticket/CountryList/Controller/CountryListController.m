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

@interface CountryListController ()

@end

@implementation CountryListController

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[CountryListView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"airportsTabTitle", @"");
    
    // Закастим вью как CountryListView
    CountryListView *view = (CountryListView *)self.view;
    
    // Объявим делегата и датасурс у тэйблвью
    self.tableView = view.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.view.backgroundColor = [UIColor whiteColor];
    
    // Объявляем делегат для поиска
    self.searchController = view.searchController;
    self.resultViewController = view.resultViewController;
    self.searchController.searchResultsUpdater = self;
    self.definesPresentationContext = YES;
    
    // Регистрируем класс для отображения ячейки
    [self.tableView registerClass:CountryListViewCell.self forCellReuseIdentifier:@"countryViewCell"];
    
    // Загружаем данные
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete:) name:kDataManagerLoadDataDidComplete object:nil];
    [[DataManager sharedInstance] loadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self doSearch:searchController.searchBar.text];
}

- (void)loadDataComplete:(NSNotification *)notification {
    // Пытаемся получить список новостей в iCloud
    NSPredicate *ckPredicate = [NSPredicate predicateWithValue:YES];
    CKContainer *container = [CKContainer containerWithIdentifier:@"iCloud.im.mga.aviaticket.cloudcontainer"];
    CKDatabase *publicDatabase = [container publicCloudDatabase];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Favorites" predicate:ckPredicate];
    
    // Выполняем запрос
    [publicDatabase performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        // Удаляем все объекты локального избранного - синхронизация будет только через облако
        [[CoreDataStack shared] removeAllFromFavorite];
        
        for (CKRecord *record in results) {
            // Создаем экземпляр новости из облачной бд
            News *news = [[News alloc] initWithTitle:record[@"title"] ShortDescription:record[@"shortDescription"] Url:record[@"url"] Source:record[@"source"] Image:record[@"imageURL"] Date:record[@"publichedAt"]];
            
            // Добавляем этот экземпляр в избранное, если его там нет
            if (![[CoreDataStack shared] favoriteFromNews:news]) {
                [[CoreDataStack shared] addToFavorite:news];
            }
        }
    }];
    
    NSArray *scens = [UIApplication sharedApplication].connectedScenes.allObjects;
    NSArray *windows = [[scens firstObject] windows];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isKeyWindow == true"];
    UIWindow *currentWinow = [[windows filteredArrayUsingPredicate:predicate] firstObject];
    currentWinow.subviews.lastObject.layer.opacity = 1;
    
    [UIView animateWithDuration:0.9 animations:^{
        currentWinow.subviews.lastObject.layer.opacity = 0;
    }];
    
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
        [self.searchController.searchBar becomeFirstResponder];
        [self.navigationController pushViewController:cityController animated:true];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)doSearch:(NSString *)query {
    // Если текстовое поле пустое значит надо вывести первоначальный список стран
    if ([query length] > 0) {
        NSArray *testCountries = [DataManager sharedInstance].countries;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS [cd] %@ OR SELF.code CONTAINS [cd] %@", query, query];
        
        self.resultViewController.results = [testCountries filteredArrayUsingPredicate:predicate];
        [self.resultViewController update];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.countries = [NSMutableArray arrayWithArray:[DataManager sharedInstance].countries];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar) {
        [self doSearch:searchBar.text];
    }
}

@end
