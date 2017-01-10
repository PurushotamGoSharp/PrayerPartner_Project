//
//  PlaymasterNew.m
//  PrayerPartner
//
//  Created by vmoksha on 09/03/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "PlaymasterNew.h"

@implementation PlaymasterNew


-(id) initWithUrl:(NSURL*)url andCount:(int)count
{
    if (self = [super init])
    {
        self.url = url;
        self.count = count;
    }
    
    return self;
}

-(BOOL) isEqual:(id)object
{
    if (object == nil)
    {
        return NO;
    }
    
    if ([object class] != [PlaymasterNew class])
    {
        return NO;
    }
    
    return [((PlaymasterNew*)object).url isEqual: self.url] && ((PlaymasterNew*)object).count == self.count;
}

-(NSString*) description
{
    return [self.url description];
}



@end
