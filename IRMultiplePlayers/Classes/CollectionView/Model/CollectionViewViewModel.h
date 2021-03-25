//
//  CollectionViewViewModel.h
//  IRMultiplePlayers
//
//  Created by irons on 2021/3/25.
//

#import <IRCollectionTableViewModel/IRCollectionTableViewModel.h>
#import "CollectionViewSectionType.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DemoItemType){
    ItemType_DemoItem
};

@interface CollectionViewItem : RowBasicModelItem

@property (readonly) DemoItemType type;

@end

@interface CollectionViewViewModel : TableViewBasicViewModel <UICollectionViewDataSource>

@property (strong) NSString *title;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (void)update;

@end

NS_ASSUME_NONNULL_END
