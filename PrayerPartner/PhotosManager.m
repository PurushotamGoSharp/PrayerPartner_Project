//
//  PhotosManager.m
//  DIEMLife
//
//  Created by vmoksha mobility on 03/07/15.
//  Copyright (c) 2015 Vmoksha. All rights reserved.
//

#import "PhotosManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface PhotosManager () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation PhotosManager


- (UIImagePickerController *)imagePickerController
{
    if (_imagePickerController == nil)
    {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
    }
    
    return _imagePickerController;
}

- (void)setDisableVideo:(BOOL)disableVideo
{
    _disableVideo = disableVideo;
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
}

- (void)showCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *validationAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera" preferredStyle:(UIAlertControllerStyleAlert)];
        [validationAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];

//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                              message:@"Device has no camera"
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles: nil];
//        
//        [myAlertView show];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:validationAlert animated:YES completion:^{
            
        }];
        return;
    }

    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.showsCameraControls = YES;
    [self.delegate photoManager:self showImageVC:self.imagePickerController];
}

- (void)showAlbum
{
    if (self.imagePickerController.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        self.imagePickerController.showsCameraControls = NO;
    }

    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.delegate photoManager:self showImageVC:self.imagePickerController];
}

#pragma mark
#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSURL *videoUrl = (NSURL*)info[UIImagePickerControllerMediaURL];
        NSString *moviePath = [videoUrl path];
        [self.delegate photosManager:self gotVideoPat:moviePath];
        
    }else if (CFStringCompare((__bridge CFStringRef)mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
        NSString *extension = [assetURL pathExtension];
        
        [self.delegate photosManager:self gotImage:chosenImage withExtension:extension];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.delegate photosManagerGotCanceled:self];
}

@end
