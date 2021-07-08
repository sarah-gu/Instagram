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

@interface TimelineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
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
    
    cell.postCaption.text = (self.posts[indexPath.row])[@"text"];
    
    PFUser *user =( self.posts[indexPath.row])[@"user"];
    cell.postUser.text = user.username;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}

- (void) queryPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Instagram_Posts"];
    [query includeKey:@"user"];
    [query includeKey:@"img"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.tableView reloadData];
}

- (IBAction)newPost:(id)sender {

    [self performSegueWithIdentifier:@"postSegue" sender:self];

}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
//
//    }
//
}

*/
@end
