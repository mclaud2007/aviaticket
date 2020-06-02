//
//  CityListController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CityListController.h"

@interface CityListController ()

@end

@implementation CityListController

- (instancetype)initWithCountry:(Country *)country {
    self = [super init];
    
    if (self) {
        self.selectedCountry = country;
        self.cities = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadCitiesByCountryCode:(NSString *)code {
    NSArray *testCities = [DataManager sharedInstance].cities;
    NSUInteger i;
    
    // Фильтруем города выбранной страны
    for (i = 0; i < [testCities count]; i++) {
        City *testCity = [testCities objectAtIndex:i];
        
        if ([testCity.countryCode isEqualToString:code]) {
            [self.cities addObject:testCity];
        }
    }
}

// MARK: Lifecycle
- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[CityListView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Название текущей страницы - выбранная страна
    self.title = self.selectedCountry.name;
    // Кастим вью
    CityListView *view = (CityListView *) self.view;
    
    self.tableView = view.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Регистрируем класс для отображения ячейки
    [self.tableView registerClass:CityListCell.self forCellReuseIdentifier:@"CityListCell"];
    
    // Загружаем данные
    [self loadCitiesByCountryCode:self.selectedCountry.code];
    [self.tableView reloadData];
}

// MARK: TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityListCell *cell = (CityListCell *) [self.tableView dequeueReusableCellWithIdentifier:@"CityListCell"];

    // Город который нужно показать
    City *city = [self.cities objectAtIndex:indexPath.row];

    // Настраиваем внешний вид ячейки
    [cell configureWith:city];
    
    return cell;
}

// MARK: TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Город который на который нужно перейти
    City *city = [self.cities objectAtIndex:indexPath.row];

    if (city != nil) {
        AirportListController *airportController = (AirportListController *) [[AirportListController alloc] initWithCity:city AndCountry:self.selectedCountry];
        [self.navigationController pushViewController:airportController animated:true];
    }

    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    
}

@end
