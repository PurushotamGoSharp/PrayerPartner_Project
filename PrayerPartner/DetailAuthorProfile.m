//
//  DetailAuthorProfile.m
//  PrayerPartner
//
//  Created by jenkins on 24/02/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "DetailAuthorProfile.h"

@interface DetailAuthorProfile ()
@property (strong, nonatomic) IBOutlet UIView *borderView;
@property (strong, nonatomic) IBOutlet UIImageView *imageDisplayLabel;
@property (strong, nonatomic) IBOutlet UITextView *textViewDisplay;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightofView;

@end

@implementation DetailAuthorProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.borderView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.borderView.layer.borderWidth=1.0f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)crossBackBtnClicked:(id)sender {
    
    NSLog(@"Frame of textView = %@", NSStringFromCGRect(self.textViewDisplay.frame));
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.imageDisplayLabel.image=[UIImage imageNamed:_authorProfileObj.imageString];
    self.textViewDisplay.text= self.authorProfileObj.theDescription;
    self.textViewDisplay.selectable = YES;
    [self.textViewDisplay setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [self.textViewDisplay setTextColor:[UIColor grayColor]];
    self.textViewDisplay.textAlignment = NSTextAlignmentCenter;
    self.textViewDisplay.selectable = NO;

    [self calculateheightoftextView:self.authorProfileObj.theDescription];
    [self.textViewDisplay setContentOffset:CGPointZero animated:NO];
}

// calculating height of title label
-(void)calculateheightoftextView:(NSString *)titleString
{
    [self.view layoutIfNeeded];

//    CGSize maximumLabelSize = CGSizeMake(self.textViewDisplay.frame.size.width, NSIntegerMax);
//    CGRect textRect = [titleString boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]} context:nil];
//    CGSize  expectedLabelSize = CGSizeMake(textRect.size.width, textRect.size.height);
  
    if (self.textViewDisplay.contentSize.height<=300) {
        self.heightofView.constant = self.textViewDisplay.contentSize.height+40;
    } else {
        self.heightofView.constant = 343;
    }
}

@end
