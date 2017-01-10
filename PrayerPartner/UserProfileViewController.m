//
//  UserProfileViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "UserProfileViewController.h"
#import "PhotosManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface UserProfileViewController ()<PhotoManagerProtocol>
{
    PhotosManager *photoManger;
   UIControl *activeField;

}


@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *upload;
- (IBAction)uploadImageButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *favoritesTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstAndLastTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //Corner setting
    _submit.layer.cornerRadius=3;
    _submit.layer.borderWidth=0;
    _upload.layer.cornerRadius=3;
    _upload.layer.borderWidth=0;
   


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];

}
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.myScrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets=UIEdgeInsetsZero;
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}
- (IBAction)KeypadHide:(id)sender {
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)uploadImageButtonAction:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Choose from:"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleActionSheet];
   
    UIAlertAction *camera = [UIAlertAction
                                  actionWithTitle:@"Camera"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      [self cameraButtonAction];
                                      NSLog(@"camera button action");
                                  }];
    UIAlertAction *gallery = [UIAlertAction
                             actionWithTitle:@"Gallery"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 NSLog(@"gallery Button button action");
                             
                                 [self galleryButtonAction];
                             }];
 
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    
    [alertController addAction:camera];
    [alertController addAction:gallery];
    [alertController addAction:cancel];
[self presentViewController:alertController animated:YES completion:nil];

}


-(void)cameraButtonAction
{
    if (photoManger == nil)
    {
        photoManger = [[PhotosManager alloc] init];
        photoManger.delegate = self;
        photoManger.disableVideo = YES;
    }
    [photoManger showCamera];
}
-(void)galleryButtonAction
{
    if (photoManger == nil)
    {
        photoManger = [[PhotosManager alloc] init];
        photoManger.delegate = self;
        photoManger.disableVideo = YES;
    }
    [photoManger showAlbum];


}
- (void)photoManager:(PhotosManager *)manager showImageVC:(UIImagePickerController *)pickerController
{
    [self presentViewController:pickerController animated:YES completion:^{
    }];
}

- (void)photosManager:(PhotosManager *)manager gotImage:(UIImage *)image withExtension:(NSString *)extension
{
    NSLog(@"Successfully got image");
    [manager.imagePickerController dismissViewControllerAnimated:YES completion:^{
        
     
      
        self.profileImage.image = image;
        [self.upload setTitle:@"" forState:UIControlStateNormal];
    
    }];
}

- (void)photosManagerGotCanceled:(PhotosManager *)manager
{
    NSLog(@"Failed to get image");
    
    [manager.imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)submitButtonAction:(id)sender {

    [self.view endEditing:YES];
    if (![self validateLoginFields])
    {
        //  TOAST_MESSAGE(@"Username and Password is required.");
        return;
    }

    
    UIAlertView *alt =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Do you want to update your profile" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alt show];
    
    
    
}

- (BOOL)validateLoginFields
{
    NSString *userName = self.firstAndLastTextField.text;
    NSString *email = self.emailTextField.text;
    
    BOOL goodToGo = YES;
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    
    if (userName.length == 0)
    {
        goodToGo = NO;
        [mutableString appendString:@"First, Last is required"];
        
    }
    if (email.length == 0)
    {
        goodToGo = NO;
        
        if (mutableString.length>0) {
            [mutableString appendString:@"\nEmail Id is required"];
        }
        else
        {
            [mutableString appendString:@"Email Id is required"];
        }
        
        
        
    }
    
    else if (![self stringIsValidEmail:self.emailTextField.text]&&userName.length!=0)
    {
        goodToGo = NO;
        [mutableString appendString:@"Please enter a valid Email Id"];
    }
    
    
    if (!goodToGo)
    {
        [self mbProgress:mutableString];
    }
    return goodToGo;
    
}

-(BOOL)stringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



- (void)mbProgress:(NSString*)message{
    MBProgressHUD *hubHUD=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hubHUD.mode=MBProgressHUDModeText;
    hubHUD.detailsLabelText=message;
    hubHUD.detailsLabelFont=[UIFont systemFontOfSize:15];
    hubHUD.margin=20.f;
    hubHUD.yOffset=150.f;
    hubHUD.removeFromSuperViewOnHide = YES;
    [hubHUD hide:YES afterDelay:2];
    
}





@end
