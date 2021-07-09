//
//  PostCollectionViewCell.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/9/21.
//

#import "PostCollectionViewCell.h"

@implementation PostCollectionViewCell

- (void) setPost:(Post *)post {
    
    
    self.myImageView.file = post[@"image"];
    
    [self.myImageView loadInBackground];
}

@end
