//
//  CollectionViewController.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 21.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
    // Регистрируем ячейку для коллекции
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.title = @"Photo";
    
    // Инициализируем пустой массив где будем хранить изображения
    self.images = [NSMutableArray array];
    
    // Изображение информация
    UIImage *infoImage = [UIImage systemImageNamed:@"plus"];
    
    // Добавляем кнопку отображения информации о текущей стране
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:infoImage style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(@"getPhotoFromPhotoLibrary")];
}

- (void)getPhotoFromPhotoLibrary {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        
        [self presentViewController:pickerController animated:true completion:nil];
    } else {
        NSLog(@"Something went wrong");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.imgPhoto.image = [_images objectAtIndex:indexPath.row];
    
    return cell;
}

@end
