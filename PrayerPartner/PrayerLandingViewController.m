//
//  PrayerLandingViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/22/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "PrayerLandingViewController.h"
#import "ReadPrayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "CustomNavController.h"
#import <AFNetworking/AFNetworking.h>
#import "NetworkRechability.h"
#import "STKAudioPlayer.h"
#import "STKAutoRecoveringHTTPDataSource.h"
#import "PlaymasterNew.h"
#import "Reachability.h"
 NetworkRechability *network;


@interface PrayerLandingViewController () <PlayMasterDelegate, UIAlertViewDelegate,STKAudioPlayerDelegate,STKDataSourceDelegate>
{
    ReadPrayerViewController *readAlong;
    AVAudioPlayer *audioPlayerBackground;
    NSMutableArray *moreArray;
    BOOL isMute;
    BOOL isFirstTimeLoad;
    BOOL isPrayAlong;
    BOOL isMoreTableHide;
    BOOL isFavorate;
    BOOL isconnected;
    NSTimer *seekTimer;
    UIAlertController *offlineAlert;
    PlayMaster *continousPrayerPlayer, *prayAlongPlayer;
    STKAudioPlayer *audioPlayer;
    STKDataSource *audioDataRegular;
    NSTimer* timer;
    
}

@property (weak, nonatomic) IBOutlet UIView *middleContainerView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *initialLabeltime;
@property (weak, nonatomic) IBOutlet UILabel *finalLabelDuration;
@property (weak, nonatomic) IBOutlet UIButton *playpaushButton;

@property (weak, nonatomic) IBOutlet UIButton *playAloneButton;
@property (weak, nonatomic) IBOutlet UIButton *readAloneButton;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *favoruteButton;
@property (weak, nonatomic) IBOutlet UITableView *MoreTable;
@property (weak, nonatomic) IBOutlet UIView *moreTableContainerView;
@property (weak, nonatomic) IBOutlet UILabel *prayerTitlelabel;

@property (strong, nonatomic) IBOutlet UILabel *buttonReadlabel;
@property (strong, nonatomic) IBOutlet UILabel *buttonprayLabel;
@property (strong, nonatomic) IBOutlet UILabel *buttonMutelabel;
@property (strong, nonatomic) IBOutlet UILabel *buttonfavoruteLabel;
@property (strong, nonatomic) IBOutlet UILabel *buttonShareLabel;

@property (strong, nonatomic) IBOutlet UILabel *MoreButtonLabel;
@property (strong, nonatomic) IBOutlet UIView *alphaView;
@property (strong, nonatomic) IBOutlet UIImageView *prayerbackgroungImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bufferingIndicator;
@property (strong, nonatomic) IBOutlet UIView *networkErrorView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *networkActivity;
@property (strong, nonatomic) IBOutlet UILabel *networkMessagelabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *networkBottomConstrant;

@end

@implementation PrayerLandingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     isFirstTimeLoad = YES;
    [self rechabalityNetworkChange];
    moreArray = @[@"Add to Playlist",@"Delete",@"Repeat",@"Make Available Offline",].mutableCopy;
    audioPlayer = [[STKAudioPlayer alloc] init];
    network=[[NetworkRechability alloc]init];
    //    [self.delegate hidetopMenu];
    self.prayerbackgroungImageView.image = [UIImage imageNamed: self.prayModel.prayerBackgroundImg];
    
    [self.muteButton setImage:[UIImage imageNamed:@"unmute-icon"] forState:UIControlStateNormal];
    [self.playAloneButton setImage:[UIImage imageNamed:@"prayaloneDisable"] forState:UIControlStateNormal];
    self.shareButton.enabled = NO;
    self.middleContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.middleContainerView.layer.borderWidth = 1.0f;
    self.prayerTitlelabel.text = self.prayModel.prayerName;
    isMute = NO;
   
    isFavorate = NO;
     isPrayAlong = NO;
    self.isPaused = YES;
    [self playbackgroundMusic];
    
   // [self performSelector:@selector(networkCheck) withObject:nil afterDelay:1.0];
    CustomNavController *customNav = (CustomNavController *)self.navigationController;
    [customNav hideMenuItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.moreTableContainerView.hidden = YES;
    isMoreTableHide = YES;
   
    self.buttonMutelabel.textColor = [UIColor whiteColor];
    self.buttonfavoruteLabel.textColor = [UIColor whiteColor];
    self.buttonprayLabel.textColor = [UIColor whiteColor];
    self.buttonShareLabel.textColor = [UIColor grayColor];
    self.MoreButtonLabel.textColor = [UIColor whiteColor];
    self.buttonReadlabel.textColor = [UIColor whiteColor];
    self.networkBottomConstrant.constant = -64;

}

- (IBAction)alphacontrollMethod:(id)sender
{
    self.moreTableContainerView.hidden= YES;
    isMoreTableHide = YES;
}

- (BOOL)isNetworkConnected {

 return [AFNetworkReachabilityManager sharedManager].reachable;

}

//-(void)networkCheck
//{
//    if (network.checkRechability) {
//    
//    }
//    else
//    {
//        NSLog(@"not connect");
//        offlineAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Internet connection appears to be offline. Please try connecting to Internet." preferredStyle:(UIAlertControllerStyleAlert)];
//        [offlineAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//            [self backButtonAction:nil];
//        }]];
//        
//        [self presentViewController:offlineAlert animated:YES completion:^{
//            
//        }];
//    }
//}






- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rechabalityNetworkChange
{
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
         isFirstTimeLoad = NO;
            [self networkViewhideMethod];
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
       
        if (isFirstTimeLoad) {
            offlineAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Internet connection appears to be offline. Please try connecting to Internet." preferredStyle:(UIAlertControllerStyleAlert)];
            [offlineAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                [self backButtonAction:nil];
            }]];
            [self presentViewController:offlineAlert animated:YES completion:^{
                
            }];
   
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                isFirstTimeLoad = NO;
                [self networkViewShowmethod];
            });
        
        }
        };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
}

-(void)networkViewShowmethod
{
    
    self.playpaushButton.enabled = NO;
    self.networkBottomConstrant.constant = 0;
    [UIView animateWithDuration:.3
                              delay:0
                            options:(UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             
                            // [self.view layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             
                         }];
        
   

}
-(void)networkViewhideMethod
{
    self.playpaushButton.enabled = YES;
    self.networkBottomConstrant.constant = -64;
        [UIView animateWithDuration:.3
                              delay:0
                            options:(UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                            // [self.view layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                         
                         }];
        

}





- (IBAction)backButtonAction:(id)sender
{
    [audioPlayer dispose];
    [audioPlayerBackground stop];
    audioPlayer = nil;
    audioPlayerBackground = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)PlayButtonAction:(id)sender
{
    if (self.isPaused)
    {
        [self setPlayerFor:isPrayAlong];
    }else
    {
        [self pauseAudio];
    }
}

- (void)setPlayerFor:(BOOL)PrayAlong
{
    if (audioPlayer.state != STKAudioPlayerStatePaused)
    {
        NSString *audioURLString;
        if (isPrayAlong)
        {
            audioURLString = self.prayModel.prayAlongUrl;
        }else
        {
            audioURLString = self.prayModel.prayContinousUrl;
        }
        NSURL* url = [NSURL URLWithString:audioURLString];
        audioDataRegular = [STKAudioPlayer dataSourceFromURL:url];
        [audioPlayer setDataSource:audioDataRegular withQueueItemId:audioURLString];
        [audioPlayer playURL:url];
        audioPlayer.delegate = self;
        [self setupTimer];

    }else
    {
        [audioPlayer resume];
    }
    self.isPaused = NO;

//    if (isPrayAlong)
//    {
//        if (audioPlayerAlone == nil)
//        {
//            NSURL* url = [NSURL URLWithString:self.prayModel.prayAlongUrl];
//            audioPlayerAlone = [[STKAudioPlayer alloc] init];
//            [audioPlayerAlone playURL:url];
//            audioPlayerAlone.delegate = self;
//            [self setupTimer];
//        }else
//        {
//            [audioPlayerAlone resume];
//        }
//        audioPlayer = audioPlayerAlone;
//    }else
//    {
//        if (audioPlayer.state != STKAudioPlayerStatePaused)
//        {
//            isFirstTimeLoad = NO;
//            NSURL* url = [NSURL URLWithString:self.prayModel.prayContinousUrl];
//            audioDataRegular = [STKAudioPlayer dataSourceFromURL:url];
//            [audioplayerRegular setDataSource:audioDataRegular withQueueItemId:self.prayModel.prayContinousUrl];
//            [audioplayerRegular playURL:url];
//            audioplayerRegular.delegate = self;
//            [self setupTimer];
//        }else
//        {
//            [audioplayerRegular resume];
//        }
//        audioPlayer = audioplayerRegular;
//    }
    
}

- (IBAction)prayAloneMethod:(id)sender
{
//    [audioPlayer seekToTime:0];
    [audioPlayer stop];
    self.isPaused = YES;
    [self updateControls];
    if (!isPrayAlong) {
        isPrayAlong = YES;
//        audioPlayer = audioPlayerAlone;
        [self.playAloneButton setImage:[UIImage imageNamed:@"Icon-Pray"] forState:UIControlStateNormal];
    }
    else
    {
        isPrayAlong = NO;
        [self.playAloneButton setImage:[UIImage imageNamed:@"prayaloneDisable"] forState:UIControlStateNormal];
//        audioPlayer = audioplayerRegular;
    }
}

- (void)switching
{
    if (audioPlayer.state == STKAudioPlayerStatePaused)
    {
        [audioPlayer resume];
    }
    else if (audioPlayer.state == STKAudioPlayerStateStopped)
    {
        [audioPlayer resume];
    }
    else
    {
        [audioPlayer pause];
    }
}

- (void)playAudio
{
    
}

- (void)pauseAudio
{
    self.isPaused = YES;
    [audioPlayer pause];
}

- (IBAction)readAloneMethod:(id)sender
{
    if (readAlong == nil) {
        readAlong = [ReadPrayerViewController ReadAloneShowController];
    }
    readAlong.scripture = self.prayModel.prayerScripture;
    readAlong.imageName = self.prayModel.scriptureImage;
    readAlong.prayerTitle = self.prayModel.prayerName;
    [self presentViewController:readAlong
                       animated:YES
                     completion:^{
                         
                     }];
    
}

- (IBAction)favorateButtonAction:(id)sender {
    
    if (!isFavorate) {
        [self.favoruteButton setImage:[UIImage imageNamed:@"Icon-FavouriteWhite"] forState:UIControlStateNormal];
        isFavorate = YES;
        [self mbProgress:@"Prayer added as favorite"];
        
    } else {
        
        [self.favoruteButton setImage:[UIImage imageNamed:@"Icon-Favourite"] forState:UIControlStateNormal];
        isFavorate = NO;
        
        [self mbProgress:@"Prayer removed as favorite"];
    }
}

- (IBAction)mutePrayMethod:(id)sender {
    if (!isMute) {
        [audioPlayerBackground pause];
        [self.muteButton setImage:[UIImage imageNamed:@"Icon-Mute"] forState:UIControlStateNormal];
        isMute = YES;
    } else {
        [audioPlayerBackground play];
        isMute = NO;
        [self.muteButton setImage:[UIImage imageNamed:@"unmute-icon"] forState:UIControlStateNormal];
    }
}

- (IBAction)moreButtonAction:(id)sender
{
    if (isMoreTableHide) {
        self.moreTableContainerView.hidden= NO;
        isMoreTableHide = NO;
    } else {
        self.moreTableContainerView.hidden= YES;
        isMoreTableHide = YES;
    }
}

- (void)playbackgroundMusic
{
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"1" ofType:@"mp3"];
    audioPlayerBackground = [[AVAudioPlayer alloc]initWithContentsOfURL:
                             [NSURL fileURLWithPath:path] error:NULL];
    [audioPlayerBackground play];
    audioPlayerBackground.volume = 0.10;
    audioPlayerBackground.numberOfLoops = -1;
}

-(void)updateControls
{
    if (self.isPaused)
    {
        [self.playpaushButton setBackgroundImage:[UIImage imageNamed:@"PlayButton"]
                                        forState:UIControlStateNormal];
    }else
    {
        [self.playpaushButton setBackgroundImage:[UIImage imageNamed:@"pauseButton"]
                                        forState:UIControlStateNormal];
    }
}

- (void)tick
{
    if (!audioPlayer)
    {
        self.slider.value = 0;
        self.initialLabeltime.text = @"00:00";
        self.finalLabelDuration.text = @"--:--";
        return;
    }
    
    if (audioPlayer.state == STKAudioPlayerStateBuffering) {
        [self.bufferingIndicator startAnimating];
    }else
    {
        [self.bufferingIndicator stopAnimating];
    }
    
    if (audioPlayer.currentlyPlayingQueueItemId == nil)
    {
        self.slider.value = 0;
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 0;
        self.initialLabeltime.text = @"00:00";
        self.finalLabelDuration.text = @"--:--";
        return;
    }
    
    if (audioPlayer.duration != 0)
    {
        self.slider.minimumValue = 0;
        self.slider.maximumValue = audioPlayer.duration;
        self.slider.value = audioPlayer.progress;
        
        self.initialLabeltime.text = [NSString stringWithFormat:@"%@", [self formatTimeFromSeconds:audioPlayer.progress]];
        self.finalLabelDuration.text = [NSString stringWithFormat:@"%@",[self formatTimeFromSeconds:audioPlayer.duration]];
    }
    else
    {
        self.slider.value = 0;
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 0;
        self.finalLabelDuration.text =  [NSString stringWithFormat:@"%@", [self formatTimeFromSeconds:audioPlayer.progress]];
    }


}

- (void)setupTimer
{
    if (timer == nil)
    {
        timer = [NSTimer timerWithTimeInterval:0.001 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (NSString*) formatTimeFromSeconds:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    //int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

- (STKAudioPlayer*)audioPlayer
{
    return audioPlayer;
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    [self updateControls];
}

- (void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    [self updateControls];
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    if (stopReason == STKAudioPlayerStopReasonEof)
    {
        self.isPaused = YES;
    }
    [self updateControls];
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer logInfo:(NSString *)line
{
    NSLog(@"%@", line);
}

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    if (!audioPlayer)
    {
        return;
    }
    
    NSLog(@"Slider Changed: %f", _slider.value);
    
    [audioPlayer seekToTime:_slider.value];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moreArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cellidentifier" forIndexPath:indexPath];
    UILabel *lab =(UILabel *)[cell viewWithTag:12];
    lab.text =moreArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)mbProgress:(NSString*)message
{
    MBProgressHUD *hubHUD=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hubHUD.mode=MBProgressHUDModeText;
    hubHUD.detailsLabelText=message;
    hubHUD.detailsLabelFont=[UIFont systemFontOfSize:15];
    hubHUD.margin=20.f;
    hubHUD.yOffset=150.f;
    hubHUD.removeFromSuperViewOnHide = YES;
    [hubHUD hide:YES afterDelay:1.0];
}

@end
