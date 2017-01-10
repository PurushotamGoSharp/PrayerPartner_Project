//
//  ViewController.h
//  SliderPrayerApp
//
//  Created by Vmoksha on 22/02/16.
//  Copyright (c) 2016 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServeyModel.h"

@interface QuestionContainerViewController : UIViewController

@property (assign, nonatomic) NSInteger pageNo;
@property (strong, nonatomic) ServeyModel *sModel;

@end

