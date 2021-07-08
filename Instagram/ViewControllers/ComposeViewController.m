//
//  ComposeViewController.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/7/21.
//

#import "ComposeViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "TimelineViewController.h"
#import "Post.h"

@interface ComposeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *captionToPost;

@property (weak, nonatomic) IBOutlet UIImageView *imageToPost;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)returnToTimeline:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)uploadImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (IBAction)onSend:(id)sender {
//    PFObject *chatMessage = [PFObject objectWithClassName:@"Instagram_Posts"];
//    chatMessage[@"text"] = self.captionToPost.text;
//    chatMessage[@"user"] = PFUser.currentUser;
//    chatMessage[@"img"] = self.imageToPost;
//    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
//        if (succeeded) {
//            NSLog(@"The message was saved!");
//            [self returnToTimeline:self];
//        } else {
//            NSLog(@"Problem saving message: %@", error.localizedDescription);
//        }
//    }];
    
    UIImage *imageToPost = self.imageToPost.image;
        NSString *captionToPost = self.captionToPost.text;
        
        [Post postUserImage:imageToPost withCaption:captionToPost withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded){
                NSLog(@"posted image successfuly");
                [self dismissViewControllerAnimated:true completion:nil];
            }
            else{
                NSLog(@"Error posting: %@", error.localizedDescription);
            }
        }];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    
    // Do something with the images (based on your use case)
    
    [self.imageToPost setImage:editedImage];
   //self.imageToPost.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    
//    
//}


@end
