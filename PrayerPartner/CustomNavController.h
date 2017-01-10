//
//  CustomNavController.h
//  PrayerPartner
//
//  Created by vmoksha mobility on 03/03/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomNavController;

@protocol CustomNavControllerDelegate <NSObject>

- (void)hideMenu:(CustomNavController *)navC;
- (void)showMenu:(CustomNavController *)navC;

@end

@interface CustomNavController : UINavigationController

@property (weak, nonatomic) id<CustomNavControllerDelegate> delegateToHideMenu;
- (void)hideMenuItem;
- (void)showMenuItem;

@end
