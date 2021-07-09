//
//  TimelineViewController.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/6/21.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "Post.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TimelineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UIImageView *storyImg1;
@property (weak, nonatomic) IBOutlet UIImageView *storyImg2;
@property (weak, nonatomic) IBOutlet UIImageView *storyImg3;
@property (weak, nonatomic) IBOutlet UIImageView *storyImg4;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self queryPosts];
    self.refreshControl = [[UIRefreshControl alloc] init]; //instantiate the refreshControl
    [self.refreshControl addTarget:self action:@selector(queryPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.storyImg1.layer.cornerRadius = 18;
    self.storyImg1.clipsToBounds = YES;
    self.storyImg2.layer.cornerRadius = 18;
    self.storyImg2.clipsToBounds = YES;
    self.storyImg3.layer.cornerRadius = 18;
    self.storyImg3.clipsToBounds = YES;
    self.storyImg4.layer.cornerRadius = 18;
    self.storyImg4.clipsToBounds = YES;


}


- (IBAction)logoutUser:(id)sender {
    
    SceneDelegate *appDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController" ];
    appDelegate.window.rootViewController = loginViewController;
    NSLog(@"logged out");
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
//    PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
//    // PFUser.current() will now be nil
//    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" ];
    NSLog(@"%@", self.posts);
    cell.postPFP.layer.cornerRadius = 20;
    cell.postPFP.clipsToBounds = YES;
    [cell setPost:self.posts[indexPath.row]];
    
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}



- (void) queryPosts{

    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = posts;
            [self.tableView reloadData];
        }
        else {
            // handle error
        }
    }];
    
    [self.refreshControl endRefreshing];
}

- (IBAction)newPost:(id)sender {

    [self performSegueWithIdentifier:@"postSegue" sender:self];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([@"detailSegue"  isEqual: segue.identifier]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        
        DetailViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post= post;
      //  NSLog(@"Tapping on a movie!");
    }
    
//
//    }
//
}


@end
