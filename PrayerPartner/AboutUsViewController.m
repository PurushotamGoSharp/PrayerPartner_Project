//
//  AboutUsViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (strong, nonatomic) IBOutlet UIButton *proceedToSurveyButton;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.borderView.layer.borderWidth = 1.0f;
    
    self.proceedToSurveyButton.hidden = !self.firstTimeUser;
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
