//
//  CollectionViewCell.h
//  IRMultiplePlayers
//
//  Created by irons on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *playerView;

+ (NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
