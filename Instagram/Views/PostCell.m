//
//  PostCell.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/7/21.
//
@import Parse;
#import "PostCell.h"
#import "DateTools.h"
@implementation PostCell
- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
    
    self.postCaption.text = post[@"caption"];
    self.postUser.text = [NSString stringWithFormat:@"@%@", post[@"author"][@"username"]];
    self.likeCount.text = [NSString stringWithFormat:@"%@", post[@"likeCount"]];
    self.retweetCount.text = [NSString stringWithFormat:@"%@", post[@"commentCount"]];
    NSDate *date = self.post.createdAt;
    self.timePosted.text =date.shortTimeAgoSinceNow;
    
}
- (IBAction)likePost:(id)sender {
    
    //get the parse object and update
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];

    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.post.objectId
                                 block:^(PFObject *parseObject, NSError *error) {
        
        parseObject[@"likeCount"] = [NSNumber numberWithFloat:([parseObject[@"likeCount"]  floatValue] + [@1 floatValue])];
        NSLog(@"%@", parseObject);
        [self.likeButton setBackgroundImage:[UIImage systemImageNamed:@"suit.heart.fill"] forState: UIControlStateNormal];
        self.likeCount.text = [NSString stringWithFormat:@"%@", parseObject[@"likeCount"]];
        [parseObject saveInBackground];
    }];
    
    
    
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
