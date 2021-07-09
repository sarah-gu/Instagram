//
//  PostCell.h
//  Instagram
//
//  Created by Sarah Wen Gu on 7/7/21.
//
@import Parse; 
#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (strong, nonatomic) Post *post;

@property (weak, nonatomic) IBOutlet UIImageView *postPFP;
@property (weak, nonatomic) IBOutlet UILabel *postUser;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *timePosted;

@end

NS_ASSUME_NONNULL_END
