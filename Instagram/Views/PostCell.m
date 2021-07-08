//
//  PostCell.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/7/21.
//
@import Parse;
#import "PostCell.h"

@implementation PostCell
- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
    
    self.postCaption.text = post[@"caption"];
    self.postUser.text = [NSString stringWithFormat:@"@%@", post[@"author"][@"username"]];
    self.likeCount.text = [NSString stringWithFormat:@"%@", post[@"likeCount"]];
    self.retweetCount.text = [NSString stringWithFormat:@"%@", post[@"commentCount"]];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
