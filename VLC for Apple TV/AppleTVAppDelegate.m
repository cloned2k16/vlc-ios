/*****************************************************************************
 * VLC for iOS
 *****************************************************************************
 * Copyright (c) 2015 VideoLAN. All rights reserved.
 * $Id$
 *
 * Authors: Felix Paul Kühne <fkuehne # videolan.org>
 *
 * Refer to the COPYING file of the official project for license.
 *****************************************************************************/

#import "AppleTVAppDelegate.h"
#import "VLCLocalNetworkTVViewController.h"
#import "VLCOpenNetworkStreamTVViewController.h"
#import "VLCSettingsTableViewController.h"
#import "VLCCloudServicesTVViewController.h"
#import "VLCHTTPUploaderController.h"

@interface AppleTVAppDelegate ()
{
    UITabBarController *_mainViewController;

    VLCLocalNetworkTVViewController *_localNetworkVC;
    VLCCloudServicesTVViewController *_cloudServicesVC;
    VLCOpenNetworkStreamTVViewController *_openNetworkVC;
    VLCSettingsTableViewController *_settingsTableVC;
}

@end

@implementation AppleTVAppDelegate

+ (void)initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *appDefaults = @{kVLCSettingContinueAudioInBackgroundKey : @(YES),
                                  kVLCSettingStretchAudio : @(NO),
                                  kVLCSettingTextEncoding : kVLCSettingTextEncodingDefaultValue,
                                  kVLCSettingSkipLoopFilter : kVLCSettingSkipLoopFilterNonRef,
                                  kVLCSettingSubtitlesFont : kVLCSettingSubtitlesFontDefaultValue,
                                  kVLCSettingSubtitlesFontColor : kVLCSettingSubtitlesFontColorDefaultValue,
                                  kVLCSettingSubtitlesFontSize : kVLCSettingSubtitlesFontSizeDefaultValue,
                                  kVLCSettingSubtitlesBoldFont: kVLCSettingSubtitlesBoldFontDefaultValue,
                                  kVLCSettingDeinterlace : kVLCSettingDeinterlaceDefaultValue,
                                  kVLCSettingNetworkCaching : kVLCSettingNetworkCachingDefaultValue,
                                  kVLCSettingEqualizerProfile : kVLCSettingEqualizerProfileDefaultValue,
                                  kVLCSettingPlaybackForwardSkipLength : kVLCSettingPlaybackForwardSkipLengthDefaultValue,
                                  kVLCSettingPlaybackBackwardSkipLength : kVLCSettingPlaybackBackwardSkipLengthDefaultValue,
                                  kVLCSettingFTPTextEncoding : kVLCSettingFTPTextEncodingDefaultValue,
                                  kVLCSettingWiFiSharingIPv6 : kVLCSettingWiFiSharingIPv6DefaultValue};
    [defaults registerDefaults:appDefaults];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _localNetworkVC = [[VLCLocalNetworkTVViewController alloc] initWithNibName:nil bundle:nil];
    _cloudServicesVC = [[VLCCloudServicesTVViewController alloc] initWithNibName:nil bundle:nil];
    _openNetworkVC = [[VLCOpenNetworkStreamTVViewController alloc] initWithNibName:nil bundle:nil];
    _settingsTableVC = [[VLCSettingsTableViewController alloc] initWithNibName:nil bundle:nil];

    _mainViewController = [[UITabBarController alloc] init];
    _mainViewController.tabBar.backgroundColor = [UIColor VLCOrangeTintColor];

    _mainViewController.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:_localNetworkVC],
                                            [[UINavigationController alloc] initWithRootViewController:_cloudServicesVC],
                                            [[UINavigationController alloc] initWithRootViewController:_openNetworkVC],
                                            [[UINavigationController alloc] initWithRootViewController:_settingsTableVC]];

    self.window.rootViewController = _mainViewController;

    // Init the HTTP Server and clean its cache
    [[VLCHTTPUploaderController sharedInstance] cleanCache];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
