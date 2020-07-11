//
//  NewsListController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 31.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NewsListController.h"
#import "CoreDataStack.h"

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
    
    self.segmentedControl = view.segmentedControl;
    
    // Объявим делегата и датасурс у тэйблвью
    self.tableView = view.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Регистрируем класс для ячейки
    [self.tableView registerClass:NewsListTableCell.self forCellReuseIdentifier:@"newsTableCell"];
    
    // Стартуем сессию
    self.service = [NetworkService instance];
    
    // Повесим обработчик нажатий на сегментед контрол
    [self.segmentedControl addTarget:self action:@selector(loadNewsFromNetOrFavorite) forControlEvents:UIControlEventValueChanged];
    
    // Загружаем список новостей
    [self loadNewsFromNetOrFavorite];
    
}

- (void)loadNewsFromNetOrFavorite
{
    // Если выбран первый сегмент - значит берем инфу из сети
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self.service getNewsList:^(NSMutableArray * _Nonnull newsListArray) {
            self.newsList = newsListArray;
            [self.tableView reloadData];
        }];
    } else {
        [self.newsList removeAllObjects];
        NSArray *favorites = [[CoreDataStack shared] favorites];
        
        for (FavoriteNews *favorite in favorites) {
            [self.newsList addObject:[[News alloc] initWithFavorite:favorite]];
        }
        
        [self.tableView reloadData];
    }
}

// MARK: TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListTableCell *cell = (NewsListTableCell *) [self.tableView dequeueReusableCellWithIdentifier:@"newsTableCell"];
    
    // Получаем новость из массива
    News *news = [_newsList objectAtIndex:indexPath.row];
    [cell configureWith:news indexPath:indexPath];
    
    // Замыкание которое вызывается при нажатии на звезду в ячейке
    cell.btnClickedDelegate = ^(NewsListTableCell *sender) {
        // Ищем новость по переданному id
        News *news = self.newsList[sender.indexPath.row];

        if (news) {
            // Проверим есть ли такая новость в избранном
            FavoriteNews *favorite = [[CoreDataStack shared] favoriteFromNews:news];
            
            if (!favorite) {
                [[CoreDataStack shared] addToFavorite:news];

                [sender.btnAddToFavorite setImage:[UIImage systemImageNamed:@"star.fill"] forState:UIControlStateNormal];
            } else {
                [[CoreDataStack shared] removeFromFavorite:news];
                
                [sender.btnAddToFavorite setImage:[UIImage systemImageNamed:@"star"] forState:UIControlStateNormal];
            }
        }
    };
    
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
