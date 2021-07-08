//
//  DetailViewController.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/8/21.
//
@import Parse;
#import "DetailViewController.h"
#import "UIKit/UIKit.h"
#import "Post.h"
#import "DateTools.h"


@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *imagePosted;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *caption;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _post = self.post;
    self.imagePosted.file = self.post[@"image"];
    [self.imagePosted loadInBackground];
    
    self.caption.text = self.post[@"caption"];
    self.username.text = [NSString stringWithFormat:@"@%@", self.post[@"author"][@"username"]];
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
    self.commentCount.text = [NSString stringWithFormat:@"%@", self.post[@"commentCount"]];
    NSDate *date = self.post.createdAt;
    self.timeStamp.text =date.shortTimeAgoSinceNow;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
