//
//  ReadPrayerViewController.h
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadPrayerViewController : UIViewController

+(ReadPrayerViewController *)ReadAloneShowController;


@property(nonatomic,strong)NSString *scripture;
@property(nonatomic,strong)NSString *imageName;
@property (strong, nonatomic) IBOutlet UIImageView *scriptureImage;
@property(nonatomic,strong)NSString *prayerTitle;
@end
