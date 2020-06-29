//
//  CollectionViewController.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 21.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *images;
@end

NS_ASSUME_NONNULL_END
