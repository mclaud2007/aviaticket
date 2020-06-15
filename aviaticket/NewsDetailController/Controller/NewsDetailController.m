//
//  NewsDetailController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 31.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NewsDetailController.h"


@interface NewsDetailController ()

@property (nonatomic) PhotoService *photoSerice;

@end

@implementation NewsDetailController

- (instancetype)initWithNews:(News *)news {
    self = [super init];
    
    // Проинициализируем данные новостью
    _news = news;
    _photoSerice = [PhotoService instance];
        
    return self;
}

- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view = [[NewsDetailView alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _news.title;
    
    // Закастим вью
    NewsDetailView *view = (NewsDetailView *)self.view;
    
    // И заполним данные
    view.lblTitle.text = _news.title;;
    view.lblContent.text = _news.short_description;
    view.lblDate.text = _news.publisherAt;
    
    // Генерим строку с ссылкой в UILabel
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_news.source attributes:nil];
    NSRange linkRange = NSMakeRange(0, [_news.source length]);
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
    };
    
    // Зададим свойства
    [attributedString setAttributes:linkAttributes range:linkRange];
    view.lblSource.attributedText = attributedString;
    view.lblSource.userInteractionEnabled = YES;
    [view.lblSource addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLinkInBrowser:)]];
    
    // Изображение для новости
    self.imgNews = view.imgNews;
    
            
    if (_news.imageUrl != nil) {
        [_photoSerice getPhotoBy:_news.imageUrl :^(UIImage * _Nonnull data) {            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imgNews.image = data;
            });
        }];
    }
}

- (void)openLinkInBrowser:(UITapGestureRecognizer *)tapGesture {
    if (_news.url != nil) {
        [[UIApplication sharedApplication] openURL:_news.url options:@{} completionHandler:nil];
    }
}

@end
