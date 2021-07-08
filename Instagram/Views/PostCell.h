//
//  PostCell.h
//  Instagram
//
//  Created by Sarah Wen Gu on 7/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postUser;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;

@end

NS_ASSUME_NONNULL_END
