//
//  AppDelegate.m
//  Instagram
//
//  Created by Sarah Wen Gu on 7/6/21.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "TimelineViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"klUFMHICooQpjqg7loClMIEOXHZZO3KryHx7nNn2"; // <- UPDATE
        configuration.clientKey = @"hiKi7b3vEzSmqKqXF2M66gmAypoOrp1nGeY3wsYa"; // <- UPDATE
        configuration.server = @"https://parseapi.back4app.com";
    }];

    [Parse initializeWithConfiguration:config];
//
//    PFObject *gameScore = [PFObject objectWithClassName:@"GameScore"];
//    gameScore[@"score"] = @1337;
//    gameScore[@"playerName"] = @"Sean Plott";
//    gameScore[@"cheatMode"] = @NO;
//    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//     if (succeeded) {
//            NSLog(@"Object saved!");
//     } else {
//            NSLog(@"Error: %@", error.description);
//     }
//    }];
//


    // Override point for customization after application launch.
    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
