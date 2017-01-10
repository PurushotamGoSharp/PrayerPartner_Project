//
//  ViewController.m
//  Cointainer_Navigation
//
//  Created by Vmoksha on 19/02/16.
//  Copyright (c) 2016 Vmoksha. All rights reserved.
//

#import "DashBoardViewController.h"
#import "TableCellClass.h"
#import "LetsUsPrayViewController.h"
#import "UserProfileViewController.h"
#import "PrayerLandingViewController.h"

#import "LoginViewController.h"
//#import "WelcomeVC.h"
//#import "officePrayerVC.h"
//#import "LetusPray.h"
#import "AboutUsViewController.h"
#import "AuthorProfileViewController.h"
#import "CustomNavController.h"

@interface DashBoardViewController ()<UITableViewDataSource , UITableViewDelegate,LandingMP3, CustomNavControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *viewCustomized;
@property(nonatomic, assign)BOOL viewDisplaying;
@property (strong, nonatomic) IBOutlet UIButton *bottomButton;
@property (strong, nonatomic) IBOutlet UIButton *topBottom;

@property (strong, nonatomic) IBOutlet UIView *containerViewForVCs;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraints;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraints;

@end

@implementation DashBoardViewController
{
    NSArray *nameArray;
    NSIndexPath *selectedIndexPath;
    CustomNavController *navController;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    UIAlertController *logOutAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
    nameArray=[[NSArray alloc]initWithObjects:@"About Us",@"Let Us Pray",@"Offer Prayer",@"Request Prayer",@"Author Profile",@"User Profile",@"Preferences", @"Log Out", nil];
    [_viewCustomized setHidden:YES];
    [_bottomButton setHidden:YES];
    self.viewDisplaying=YES;
    selectedIndexPath = nil;

//    PrayerLandingViewController *prayerland =[[PrayerLandingViewController alloc]init];
//    prayerland.delegate = self;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.bottomConstraints.constant = [UIScreen mainScreen].bounds.size.height;

     self.topConstraints.constant = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);


}
-(void)hidetopMenu
{
   // self.topBottom.hidden = YES;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableCellClass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.nameLabel.text=nameArray[indexPath.row];
    
    if (indexPath.row == 2 || indexPath.row == 3 ||indexPath.row == 6 )
    {
        cell.nameLabel.textColor = [UIColor grayColor];
    }else
    {
        cell.nameLabel.textColor = [UIColor whiteColor];
    }
    
//    if (indexPath.row == 0 || indexPath.row == 7 )
//    {
//        cell.nameLabel.textColor = [UIColor whiteColor];
//    }
//    else
//    {
//        cell.nameLabel.textColor = [UIColor grayColor];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *navRootVC = [navController topViewController];
    if (indexPath.row==0) {
        
        //        AboutUSID
        
        if (![navRootVC isKindOfClass:[AboutUsViewController class]])
        {
            AboutUsViewController *aboutusObj = (AboutUsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUSID"];
            [navController setViewControllers: [NSArray arrayWithObject: aboutusObj] animated: NO];
        }
        [self performSelector:@selector(hideMenu) withObject:nil afterDelay:.1];
        
//        [self hideMenu];

        NSLog(@"1st cell tapped");
    }
    
    else if (indexPath.row==1)
    {
        if (![navRootVC isKindOfClass:[LetsUsPrayViewController class]])
        {
            
            LetsUsPrayViewController *letsUsp = (LetsUsPrayViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LetsprayStorayBoardId"];
            [navController setViewControllers: [NSArray arrayWithObject: letsUsp]
                                     animated: NO];
        }
        [self performSelector:@selector(hideMenu) withObject:nil afterDelay:.1];

//        [self hideMenu];
    }
    else if (indexPath.row==4)
    {
        if (![navRootVC isKindOfClass:[AuthorProfileViewController class]])
        {
            AuthorProfileViewController *AutherProfile = (AuthorProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AuthorPID"];
            //        [self presentViewController:letspray animated:YES completion:nil];
            [navController setViewControllers: [NSArray arrayWithObject: AutherProfile]
                                     animated: NO];
        }
        
        [self performSelector:@selector(hideMenu) withObject:nil afterDelay:.1];
//        [self hideMenu];
        
    }
    
    else if (indexPath.row == 5)
    {
        if (![navRootVC isKindOfClass:[UserProfileViewController class]])
        {
            UserProfileViewController *userprofile = (UserProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UserprofileID"];
            [navController setViewControllers: [NSArray arrayWithObject: userprofile]
                                     animated: NO];
        }
        [self performSelector:@selector(hideMenu) withObject:nil afterDelay:.1];

//        [self hideMenu];
    }
    
    else if (indexPath.row==7)
    {
        logOutAlert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Do you want to Log Out?" preferredStyle:UIAlertControllerStyleAlert];
        [logOutAlert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [logOutAlert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for (UIViewController *vc in [self.navigationController viewControllers]) {
                if ([vc isKindOfClass: [LoginViewController class]]){
                    [[self navigationController] popToViewController:vc animated:YES];
                }
            }
            
           // [self.navigationController popToRootViewControllerAnimated:YES];
        
        }]];
        [self presentViewController:logOutAlert animated:YES completion:^{
            
        }];
    }
    else
    {
        NSLog(@"some other  cell tapped");
        
    }
//    self.viewCustomized.hidden = YES;
//    self.topBottom.hidden = NO;
//    self.viewDisplaying = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender
{
    [self showMenu];
}

- (IBAction)bottomButtonClicked:(id)sender
{
    [self hideMenu];
}

- (void)showMenu
{
    if (self.viewDisplaying==YES)
    {
        self.topConstraints.constant = 0;
        _viewCustomized.hidden = NO;
        //[_topBottom setHidden:YES];
        self.viewDisplaying=NO;
        [_bottomButton setHidden:NO];
        
        [UIView animateWithDuration:.6
                              delay:0
                            options:(UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             
                             [self.view layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             
                         [_topBottom setEnabled:NO];
                         
                         }];
     
    }
}
- (void)hideMenu
{
    if ((self.viewDisplaying=YES))
    {
        self.topConstraints.constant = [UIScreen mainScreen].bounds.size.height;
        [_bottomButton setHidden:YES];
        
        [UIView animateWithDuration:.6
                              delay:0
                            options:(UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             [self.view layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             [_viewCustomized setHidden:YES];
                            // [_topBottom setHidden:NO];
                             [_topBottom setEnabled:YES];
                         }];
        
        [CATransaction begin];
        [self.containerViewForVCs.layer removeAllAnimations];
        [CATransaction commit];

    
    }
}

- (void)hideMenu:(CustomNavController *)navC
{
    [_topBottom setHidden:YES];
}

- (void)showMenu:(CustomNavController *)navC
{
    [_topBottom setHidden:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbedViewCSegue"])
    {
        navController = segue.destinationViewController;
        navController.delegateToHideMenu = self;
    }
}

@end
