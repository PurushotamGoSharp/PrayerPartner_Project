//
//  CustomNavController.m
//  PrayerPartner
//
//  Created by vmoksha mobility on 03/03/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "CustomNavController.h"

@interface CustomNavController ()

@end

@implementation CustomNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideMenuItem
{
    [self.delegateToHideMenu hideMenu:self];
}
- (void)showMenuItem
{
    [self.delegateToHideMenu showMenu:self];
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
