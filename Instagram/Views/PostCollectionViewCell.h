//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Sarah Wen Gu on 7/9/21.
//
@import Parse;
#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *myImageView;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
