//
//  SceneDelegate.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 17.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "SceneDelegate.h"
#import "CountryListController.h"
#import "NewsListController.h"
#import "CountryListController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Создаем окно, если его нет
    if (self.window == nil && [scene isKindOfClass:[UIWindowScene class]]) {
        self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    }

    // Приложение завернуто в ТабБарконтрол
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    // Вкладка новостей
    UITabBarItem *newsListItem = [[UITabBarItem alloc] initWithTitle:@"News" image:[UIImage systemImageNamed:@"book"] tag:0];
    NewsListController *newsList = [[NewsListController alloc] init];
    
    // Она завернута в навигешен контроллер
    UINavigationController *newsNavController = [[UINavigationController alloc] initWithRootViewController:newsList];
    newsNavController.tabBarItem = newsListItem;

    // Вкладка со странами
    UITabBarItem *countryListItem = [[UITabBarItem alloc] initWithTitle:@"Airports" image:[UIImage systemImageNamed:@"airplane"] tag:1];
    CountryListController *countryList = [[CountryListController alloc] init];
    
    // У нее отдельный навигейшен контроллер
    UINavigationController *navCountryControll = [[UINavigationController alloc] initWithRootViewController:countryList];
    navCountryControll.tabBarItem = countryListItem;

    tabBar.viewControllers = @[navCountryControll, newsNavController];
    
    // Показываем окно
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
