//
//  NetworkRechability.h
//  BOOST
//
//  Created by Saurabh Suman on 29/06/15.
//  Copyright (c) 2015 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRechability : NSObject

// Declaration of Network checking Method
- (BOOL)checkRechability;
@property(nonatomic,assign)BOOL isNetwork;

@end
