//
//  ViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworkReachabilityManager.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *swipeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.backgroundImageView.image = [UIImage imageNamed:@"LaunchImageiPhone6"];
    self.swipeLabel.layer.cornerRadius = 5;




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(id)sender
{
    [self performSegueWithIdentifier:@"SplashToLoginSegue" sender:nil];
}

@end
