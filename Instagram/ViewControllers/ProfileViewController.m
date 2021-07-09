//
//  ProfileViewController.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/9/21.
//
@import Parse;

#import "ProfileViewController.h"
#import "Post.h"
#import "PostCollectionViewCell.h"
#import <UIKit/UIKit.h>


@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *filteredPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PostCollectionViewCell"];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
        
    layout.minimumInteritemSpacing = 2.5;
    layout.minimumLineSpacing = 2.5;
    
    CGFloat postsPerRow = 3;
    CGFloat itemWidth = (self.view.frame.size.width - layout.minimumInteritemSpacing * (postsPerRow - 1)) / postsPerRow;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    [self queryPosts];
    [self queryMyPosts];
    self.username.text = [PFUser currentUser][@"username"];
    NSLog(@"%@", self.username.text);
    self.filteredPosts = self.posts;
    

    [self.collectionView reloadData];
    
    
}
- (void) queryMyPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"creationDate"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    query.limit = 20;

    [query includeKey:@"author"];

    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.filteredPosts = posts;
            self.numPosts.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.filteredPosts.count];
            [self.collectionView reloadData];
        }
        else {
            // handle error
        }
    }];
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
          //  [self.collectionView reloadData];
        }
        else {
            // handle error
        }
    }];
    
  //  [self.refreshControl endRefreshing];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    cell.post = self.filteredPosts[indexPath.item];

    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.filteredPosts.count;
    
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
