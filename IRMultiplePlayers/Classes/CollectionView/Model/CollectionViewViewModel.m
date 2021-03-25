//
//  CollectionViewViewModel.m
//  IRMultiplePlayers
//
//  Created by irons on 2021/3/25.
//

#import "CollectionViewViewModel.h"
#import "CollectionViewCell.h"

@implementation CollectionViewItem
@dynamic type;
@end

@interface CollectionViewSectionItem : SectionBasicModelItem
@property (nonatomic) NSString* sectionTitle;
@property (nonatomic) SectionType type;
@end

@implementation CollectionViewSectionItem
@end

@interface CollectionViewViewModel ()
@end

@implementation CollectionViewViewModel

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    if (self = [super init]) {
        items = [[NSMutableArray<id<SectionModelItem>> alloc] init];
    }
    return self;
}

- (void)update {
    [items removeAllObjects];
    [self setupRows];
}

- (void)setupRows {
    NSMutableArray *rowItems = [NSMutableArray array];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    [rowItems addObject:[[CollectionViewItem alloc] initWithType:ItemType_DemoItem withTitle:@"Demo Row"]];
    NSArray *demoRowItems = [NSArray arrayWithArray:rowItems];
    CollectionViewSectionItem *item = [[CollectionViewSectionItem alloc] initWithRowCount:[demoRowItems count]];
    item.type = PlayersSection;
    item.sectionTitle = @"Demo Section";
    item.rows = demoRowItems;
    [items addObject:item];
    
    [self setupRowTag];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [items[section] rowCount];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<SectionModelItem> item = [items objectAtIndex:indexPath.section];
    CollectionViewItem *row = (CollectionViewItem *)[item.rows objectAtIndex:[indexPath row]];
    
    switch (item.type) {
        case PlayersSection:
        {
            switch (row.type) {
                case ItemType_DemoItem:
                {
                    NSString *identifier = [NSString stringWithFormat:@"Identifier_%d-%d-%d", (int)indexPath.section, (int)indexPath.row, (int)indexPath.item];
                    [collectionView registerNib:[UINib nibWithNibName:CollectionViewCell.identifier bundle:nil] forCellWithReuseIdentifier:identifier];

                    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                    
                    cell.titleLabel.text = [NSString stringWithFormat:@"%@%ld", row.title, row.tagRange.location];
                    
                    return cell;
                }
            }
            break;
        }
        default:
            break;
    }
    return [[UICollectionViewCell alloc] init];
}

@end
