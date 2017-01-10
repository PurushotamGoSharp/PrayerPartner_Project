//
//  PlayMaster.m
//  PrayerPartner
//
//  Created by Saurabh on 2/23/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "PlayMaster.h"
@interface PlayMaster()
{
    AVPlayerItem *playerItem;
    AVPlayer *player;
}
@end

@implementation PlayMaster

- (instancetype)initPlayerWithUrl:(NSString *)urlString
{
    if (self = [super init])
    {
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        playerItem = [[AVPlayerItem alloc]initWithURL:url];
        player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [player addObserver:self forKeyPath:@"status" options:0 context:nil];

    }
    
    return self;
}

- (void)playAudio
{
    [player play];
}

- (void)pauseAudio
{
    [player pause];
}

-(void)stopAudio
{
    //    [playerItem asset];
}

- (BOOL)isPlaying
{
    if (player.rate != 0)
    {
        // player is playing
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString*)timeFormat:(float)value
{
    float minutes = floor(lroundf(value)/60);
    float seconds = lroundf(value) - (minutes * 60);
    
    int roundedSeconds = roundf(seconds);
    int roundedMinutes = roundf(minutes);
    
    NSString *time = [[NSString alloc] initWithFormat:@"%d:%02d", roundedMinutes, roundedSeconds];
    return time;
}

- (void)setCurrentAudioTime:(float)value
{
    CMTime seekingCM = CMTimeMake(value, 1);
    [player seekToTime:seekingCM];
}

- (NSTimeInterval)getCurrentAudioTime
{
    float currentTime = (float)CMTimeGetSeconds([player currentTime]);
    return currentTime;
}

- (float)getAudioDuration
{
    CMTime time =  playerItem.asset.duration;
    float timeInSec = (float) CMTimeGetSeconds(time);
    return timeInSec;
}

- (void)dealloc
{
    [player removeObserver:self forKeyPath:@"status"];
    NSLog(@"Dealloced Player");
}

- (void)itemDidFinishPlaying:(NSNotification *)notification
{
    [self.delegate playerMaster:self finishedPlaying:playerItem];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([object isEqual:player] && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
//            [player play];
            
        } else if (player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}

@end
