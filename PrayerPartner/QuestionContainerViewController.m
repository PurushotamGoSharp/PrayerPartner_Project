//
//  ViewController.m
//  SliderPrayerApp
//
//  Created by Vmoksha on 22/02/16.
//  Copyright (c) 2016 Vmoksha. All rights reserved.
//

#import "QuestionContainerViewController.h"

@interface QuestionContainerViewController () <UIAlertViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *sliderButton;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratelabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingOnelabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingThreelabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingFivelabel;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIView *boarderView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property(assign,nonatomic) NSInteger countValue;

@end

@implementation QuestionContainerViewController
{
    NSMutableArray *dataArray;
//    ServeyModel *sModel;
    BOOL sliderValueChanged;
    NSInteger sliderValue;
    UIAlertController *validationAlert;
    UITapGestureRecognizer *tapGestureRecognizer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    _countValue=0;
    _sliderButton.minimumValue = 1.0;
    _sliderButton.maximumValue = 5.0;
    _sliderButton.continuous = YES;
    sliderValue = 1;
    self.nextButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.nextButton.layer.borderWidth = 1.0;
    
    self.boarderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.boarderView.layer.borderWidth = 1.0;
    
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)] ;
    tapGestureRecognizer.delegate=self;
    
    [self.sliderButton addGestureRecognizer:tapGestureRecognizer];
    
    [self aDummyData];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.sModel == nil)
    {
        self.sModel = [dataArray firstObject];
        self.backButton.hidden = YES;
    }

    [self dataDisplay];
}

- (void)sliderTapped:(UIGestureRecognizer *)gestureRecognizer {
    _sliderButton = (UISlider *) gestureRecognizer.view;
    
    tapGestureRecognizer.numberOfTapsRequired=1;
    tapGestureRecognizer.numberOfTouchesRequired=1;
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UISlider class]]) {
        
        CGPoint touchpoint = [touch locationInView:self.sliderButton];
        
        CGRect sliderFrame = self.sliderButton.frame;
        float sliderWidth;
        sliderWidth =  sliderFrame.size.width ;
        
        NSInteger equalPart = sliderWidth/4;
        CGFloat value = touchpoint.x/equalPart;
        sliderValue = roundf(value);
        self.sliderButton.value = sliderValue + 1;
        sliderValueChanged = YES;

        return NO;
        
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataDisplay
{
    self.sliderButton.value = 0;
    self.headerLabel.text = self.sModel.headStr;
    self.ratelabel.text=self.sModel.rateStr;
    self.ratingOnelabel.text=self.sModel.rateOneStr;
    self.ratingThreelabel.text=self.sModel.ratethreeStr;
    self.ratingFivelabel.text=self.sModel.rateFiveStr;
    
    [self.nextButton setTitle:self.sModel.nextBtnStr forState:(UIControlStateNormal)];
}

- (IBAction)slidervalueChange:(UISlider *)sender
{
//   self.sliderButton.value = roundf(sender.value);
    sliderValueChanged = YES;
    self.sliderButton.value = roundf(sender.value);

//    [self.sliderButton setValue:roundf(sender.value) animated:YES];
}

- (IBAction)nextButtonClicked:(id)sender
{
    if (sliderValueChanged)
    {
        [self proceedToNextScreen];
    }else
    {
        if (validationAlert == nil)
        {
            validationAlert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to proceed?" preferredStyle:(UIAlertControllerStyleAlert)];
            [validationAlert addAction:[UIAlertAction actionWithTitle:@"No" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [validationAlert addAction:[UIAlertAction actionWithTitle:@"Yes" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self proceedToNextScreen];
            }]];

//            validationAlert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@" Are you sure you want to proceed?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        }
//        [validationAlert show];
        [self presentViewController:validationAlert animated:YES completion:^{
            
        }];
    }
}

- (void)proceedToNextScreen
{
    if (self.pageNo < dataArray.count-1)
    {
        QuestionContainerViewController *questVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionContainerViewControllerID"];
        questVC.pageNo = self.pageNo + 1;
        questVC.sModel = dataArray[questVC.pageNo];
        [self.navigationController pushViewController:questVC animated:YES];
    }else if (self.pageNo == dataArray.count-1)
    {
        [self performSegueWithIdentifier:@"welcomeSegue" sender:self];
    }
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if ([alertView isEqual:validationAlert])
//    {
//        if (buttonIndex == 1)
//        {
//            [self proceedToNextScreen];
//        }
//    }
//}

- (NSArray *)aDummyData
{
    dataArray = [[NSMutableArray alloc] init];
    ServeyModel *survey;
    survey=[ServeyModel new];
    survey.headStr=@"Do you believe in prayer? ";
    survey.rateStr=@"(Rate on a scale of 1-5)";
    survey.rateOneStr=@"Not sure";
    survey.ratethreeStr=@"Could be persuaded";
    survey.rateFiveStr=@"Absolutely";
    survey.nextBtnStr=@"Next";
    [dataArray addObject:survey];
    
    
    survey=[ServeyModel new];
    survey.headStr=@"How often do you pray? ";
    survey.rateStr=@"(Rate on a scale of 1-5)";
    survey.rateOneStr=@"I don't pray";
    survey.ratethreeStr=@"I pray on special occasions";
    survey.rateFiveStr=@"I pray daily";
    survey.nextBtnStr=@"Next";
    [dataArray addObject:survey];
    
    survey=[ServeyModel new];
    survey.headStr=@"When was the last time you prayed? ";
    survey.rateStr=@"(Rate on a scale of 1-5)";
    survey.rateOneStr=@"I don't pray";
    survey.ratethreeStr=@"My last special occasions or time of need";
    survey.rateFiveStr=@"Today";
    survey.nextBtnStr=@"Submit";
    [dataArray addObject:survey];
    
    
    return dataArray;
}


@end
