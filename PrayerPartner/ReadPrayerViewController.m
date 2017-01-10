//
//  ReadPrayerViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "ReadPrayerViewController.h"
#import "AppDelegate.h"
@interface ReadPrayerViewController ()
@property (strong, nonatomic) IBOutlet UITextView *scriptureTextView;
@property (strong, nonatomic) IBOutlet UILabel *prayerName;

@end

@implementation ReadPrayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scriptureTextView.text = self.scripture;
    self.scriptureImage.image = [UIImage imageNamed:self.imageName];
    self.prayerName.text = self.prayerTitle;
    [self.view layoutIfNeeded];
    [self.scriptureTextView setContentOffset:CGPointZero animated:NO];
 
    self.scriptureTextView.selectable = YES;
    [self.scriptureTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [self.scriptureTextView setTextColor:[UIColor grayColor]];
    self.scriptureTextView.textAlignment = NSTextAlignmentCenter;
    self.scriptureTextView.selectable = NO;

    
    
    
}



+(ReadPrayerViewController *)ReadAloneShowController
{
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    return [appDel.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"ReadAloneViewController"];
}


- (IBAction)dismissControllerMethod:(id)sender {
[self dismissViewControllerAnimated:YES completion:^{
    
}];


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
