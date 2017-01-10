//
//  PrayerLandingViewController.h
//  PrayerPartner
//
//  Created by Saurabh on 2/22/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayMaster.h"
#import "PrayListModel.h"

@protocol LandingMP3 <NSObject>

-(void)hidetopMenu;

@end

@interface PrayerLandingViewController : UIViewController

@property(nonatomic,weak)id<LandingMP3>delegate;

@property (nonatomic, strong) PlayMaster *audioPlayer;
@property(nonatomic,strong) PrayListModel *prayModel;

@property BOOL isPaused;
@property BOOL scrubbing;

@property NSTimer *timer;
@end
