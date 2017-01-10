//
//  PlaymasterNew.h
//  PrayerPartner
//
//  Created by vmoksha on 09/03/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaymasterNew : NSObject
@property (readwrite) int count;
@property (readwrite) NSURL* url;

-(id) initWithUrl:(NSURL*)url andCount:(int)count;

@end
