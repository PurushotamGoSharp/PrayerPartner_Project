//
//  PrayListModel.h
//  PrayerPartner
//
//  Created by Saurabh on 2/22/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrayListModel : NSObject

@property(nonatomic,strong)NSString *prayerName;
@property(nonatomic,strong)NSString *prayerAuthor;
@property(nonatomic,strong)NSString *prayerDuration;

@property(nonatomic,strong)NSString *prayerScripture;
@property(nonatomic,strong)NSString *prayAlongUrl;
@property(nonatomic,strong)NSString *prayContinousUrl;

@property(nonatomic,strong)NSString *scriptureImage;
@property(nonatomic,strong)NSString *prayerBackgroundImg;

@end
