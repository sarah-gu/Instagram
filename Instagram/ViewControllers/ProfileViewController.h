//
//  ProfileViewController.h
//  Instagram
//
//  Created by Sarah Wen Gu on 7/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *username;

@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UILabel *numPosts;

@end

NS_ASSUME_NONNULL_END
