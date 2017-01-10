//
//  PlayMaster.h
//  PrayerPartner
//
//  Created by Saurabh on 2/23/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class PlayMaster;

@protocol PlayMasterDelegate <NSObject>

- (void)playerMaster:(PlayMaster *)master finishedPlaying:(AVPlayerItem *)item;

@end

@interface PlayMaster : NSObject

@property (weak, nonatomic) id<PlayMasterDelegate> delegate;
// Public methods
- (void)playAudio;
- (void)pauseAudio;
-(void)stopAudio;

- (BOOL)isPlaying;
- (void)setCurrentAudioTime:(float)value;
- (float)getAudioDuration;
- (NSString*)timeFormat:(float)value;
- (NSTimeInterval)getCurrentAudioTime;

- (instancetype)initPlayerWithUrl:(NSString *)urlString;

@end
