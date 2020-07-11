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
    
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 50);
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:rect];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Новости", @"Избранное"]];
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
    self.segmentedControl.selectedSegmentIndex = 0;
    [tableHeaderView addSubview:_segmentedControl];
    self.tableView.tableHeaderView = tableHeaderView;
    
    [self addSubview:self.tableView];
    
    // Констрейнты для таблиы
    NSLayoutConstraint *topTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leftTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *rightTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *leftSegmentedControl = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *rightSegmentedControl = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint *topSegmentedControl = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *bottomSegmentedControl = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tableHeaderView attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    
    // Массив констрейнтов для активации
    NSArray *constraints = [NSArray arrayWithObjects:topTableViewConstraint, bottomTableViewConstraint, leftTableViewConstraint, rightTableViewConstraint, leftSegmentedControl, rightSegmentedControl, topSegmentedControl, bottomSegmentedControl, nil];
    
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
