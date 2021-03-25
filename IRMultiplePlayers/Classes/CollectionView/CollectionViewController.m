//
//  CollectionViewController.m
//  IRMultiplePlayers
//
//  Created by irons on 2021/3/25.
//

#import "CollectionViewController.h"
#import "CollectionViewViewModel.h"
#import "TableViewCell.h"

@interface CollectionViewController () <UICollectionViewDelegate>

@property CollectionViewViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[CollectionViewViewModel alloc] initWithCollectionView:self.collectionView];
    [self.viewModel update];
    
    self.collectionView.dataSource = self.viewModel;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat itemWidth,itemHeight;
    itemWidth = self.collectionView.bounds.size.width/2 - 10;
    itemHeight = itemWidth/16*11;

    self.collectionView.pagingEnabled = NO;
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).itemSize = CGSizeMake(itemWidth, itemHeight);
}

@end

