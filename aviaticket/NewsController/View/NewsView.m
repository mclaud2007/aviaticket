//
//  NewsView.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 31.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NewsView.h"

@implementation NewsView

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
    
    // Создаем tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.frame];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.tableView];
    
    // Констрейнты для таблиы
    NSLayoutConstraint *topTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leftTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *rightTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    // Массив констрейнтов для активации
    NSArray *constraints = [NSArray arrayWithObjects:topTableViewConstraint, bottomTableViewConstraint, leftTableViewConstraint, rightTableViewConstraint, nil];
    
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
