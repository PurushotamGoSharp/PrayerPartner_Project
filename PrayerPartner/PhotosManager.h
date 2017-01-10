//
//  PhotosManager.h
//  DIEMLife
//
//  Created by vmoksha mobility on 03/07/15.
//  Copyright (c) 2015 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotosManager;

@protocol PhotoManagerProtocol <NSObject>

- (void)photoManager:(PhotosManager *)manager showImageVC:(UIImagePickerController *)pickerController;

- (void)photosManager:(PhotosManager *)manager gotImage:(UIImage *)image withExtension:(NSString *)extension;
- (void)photosManager:(PhotosManager *)manager gotVideoPat:(NSString *)path;

- (void)photosManagerGotCanceled:(PhotosManager *)manager;

@end

@interface PhotosManager : NSObject

@property (weak, nonatomic) id <PhotoManagerProtocol> delegate;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (assign, nonatomic) BOOL disableVideo;
- (void)showAlbum;
- (void)showCamera;

@end
