//
//  WelcomeVC.m
//  PrayerPartner
//
//  Created by Vmoksha on 25/02/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "WelcomeVC.h"

@interface WelcomeVC ()
@property (strong, nonatomic) IBOutlet UIView *borderView;

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.borderView.layer.borderWidth = 1.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
