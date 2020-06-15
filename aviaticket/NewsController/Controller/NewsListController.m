//
//  NewsListController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 31.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NewsListController.h"

@interface NewsListController ()

@end

@implementation NewsListController

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[NewsView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Новости";
    
    // Закастим текущюю вью как NewsList
    NewsView *view = (NewsView *)self.view;
    
    // Объявим делегата и датасурс у тэйблвью
    self.tableView = view.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Регистрируем класс для ячейки
    [self.tableView registerClass:NewsListTableCell.self forCellReuseIdentifier:@"newsTableCell"];
    
    // Стартуем сессию
    self.service = [NetworkService instance];
    
    // Загружаем список новостей
    [self.service getNewsList:^(NSMutableArray * _Nonnull newsListArray) {
        self.newsList = newsListArray;
        [self.tableView reloadData];
    }];
    
}

// MARK: TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListTableCell *cell = (NewsListTableCell *) [self.tableView dequeueReusableCellWithIdentifier:@"newsTableCell"];
    
    // Получаем новость из массива
    News *news = [_newsList objectAtIndex:indexPath.row];
    [cell configureWithNews:news];    
    
    return cell;
}

// MARK: TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Получаем новость из массива
    News *news = [_newsList objectAtIndex:indexPath.row];
    
    // Инициализируем страницу с детальным описанием новости
    UIViewController *newsDetail = (NewsDetailController *)[[NewsDetailController alloc] initWithNews:news];
    
    // Покажем страницу
    [self.navigationController pushViewController:newsDetail animated:YES];
    
    // Снимаем выделение текущей строчки
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
