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
    
    NSString *loadingText = NSLocalizedString(@"loading", @"");
    CGFloat labelWidth = (self.bounds.size.width / 2);
    UIFont *font = [UIFont systemFontOfSize:30];
    CGSize size = CGSizeMake(self.bounds.size.width/2, FLT_MAX);
    CGRect rectLabel = [loadingText boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    
    // Надпись "загрузка"
    CGRect lblLoadingRect = CGRectMake((self.bounds.size.width / 2) - ((rectLabel.size.width/2) + 10),
                                       (self.bounds.size.height / 2) - ((rectLabel.size.height/2) - 10),
                                       labelWidth,
                                       rectLabel.size.height
    );
    
    self.lblLoading = [[UILabel alloc] initWithFrame:lblLoadingRect];
    self.lblLoading.font = font;
    self.lblLoading.text = loadingText;
    self.lblLoading.textColor = UIColor.whiteColor;
    
    // Создаем таблицу для данных
    self.tableView = [[UITableView alloc] initWithFrame:self.frame];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    self.tableView.userInteractionEnabled = true;
    [self addSubview:self.tableView];
    
    // Инициализируем searchController
    self.resultViewController = [[SearchResultControllerTableViewController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultViewController];
    self.searchController.definesPresentationContext = true;
    self.searchController.obscuresBackgroundDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    
    // В её хедер добавляем поле для поиска
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Экран загрузки
    CGRect viewLoadingScreenRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    self.loadingScreen = [[UIView alloc] initWithFrame:viewLoadingScreenRect];
    self.loadingScreen.backgroundColor = UIColor.systemGreenColor;
    [self.loadingScreen addSubview:self.lblLoading];
    
    // Выводим на экран экран загрузки
    NSArray *scens = [UIApplication sharedApplication].connectedScenes.allObjects;
    NSArray *windows = [[scens firstObject] windows];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isKeyWindow == true"];
    UIWindow *currentWinow = [[windows filteredArrayUsingPredicate:predicate] firstObject];
    [currentWinow addSubview:self.loadingScreen];
    
    // Настриваем констрейнты для tableView
    NSLayoutConstraint *topTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *leftTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightTableViewConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    // массив констрейнтов для активации
    NSArray *constaints = [NSArray arrayWithObjects:topTableViewConstraint, bottomTableViewConstraint, leftTableViewConstraint, rightTableViewConstraint, nil];
    [NSLayoutConstraint activateConstraints:constaints];
    
    self.lblLoading.layer.opacity = 0;
    
    [UIView animateWithDuration:0.9 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        self.lblLoading.layer.opacity = 1;
    } completion:nil];
}

@end
