//
//  CountryListView.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CountryListView.h"

@implementation CountryListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self configureUI];
    }
    
    return self;
}

- (void)configureUI {
    // Цвет фона будет белый
    self.backgroundColor = [UIColor whiteColor];
    
    // Создаем таблицу для данных
    self.tableView = [[UITableView alloc] initWithFrame:self.frame];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    self.tableView.userInteractionEnabled = true;
    [self addSubview:self.tableView];
    
    // Инициализируем searchController
    self.searchController = [[UISearchController alloc] init];
    self.searchController.definesPresentationContext = false;
    self.searchController.obscuresBackgroundDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    
    // В её хедер добавляем поле для поиска
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Настриваем констрейнты для tableView
    NSLayoutConstraint *topTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *leftTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    // массив констрейнтов для активации
    NSArray *constaints = [NSArray arrayWithObjects:topTableViewConstraint, bottomTableViewConstraint, leftTableViewConstraint, rightTableViewConstraint, nil];
    [NSLayoutConstraint activateConstraints:constaints];
}

@end
