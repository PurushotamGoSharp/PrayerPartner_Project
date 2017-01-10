//
//  LoginViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//
#import "iToast.h"
#import "LoginViewController.h"
#import "ForgotPasswordView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Constant.h"
#import "Postman.h"
#import "AppDelegate.h"

@interface LoginViewController ()

{
    
    
    ForgotPasswordView *forgotPasswordView;

    UIControl *activeField;
    Postman *postman;
}




@property (weak, nonatomic) IBOutlet UIButton *dontHaveAcountButton;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXconstrant;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
   
    AppDelegate *appDel =(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.isLogin = YES;
    postman =[[Postman alloc]init];
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    
    self.facebookLoginButton.enabled = YES;
    self.forgotPasswordButton.enabled = YES;
    
    [self.emailTextField setValue:[UIColor grayColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor grayColor]
                       forKeyPath:@"_placeholderLabel.textColor"];

   // NSLog(@"%f  %f",self.view.frame.size.height,self.view.frame.size.width);
    
    

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
//    self.emailTextField.text = @"";
//    self.passwordTextField.text = @"";
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
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets=UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}



- (IBAction)dismisskeypadMethod:(id)sender {
    
    [self.view endEditing:YES];
}


- (IBAction)DontHaveAccount:(id)sender {
    [self performSegueWithIdentifier:@"LoginToSignup" sender:self];

}
- (IBAction)LoginButtonAction:(id)sender {
   [self.view endEditing:YES];
    if (![self validateLoginFields])
    {
        //  TOAST_MESSAGE(@"Username and Password is required.");
        return;
    }
    if ([self.emailTextField.text isEqualToString:@"prayerseeker@prayerpartner.mobi"]&&[self.passwordTextField.text isEqualToString:@"mark1124"]) {
       [self performSegueWithIdentifier:@"logintothanku" sender:self];
       // [self callApiForLogin];
        
    }
   else
   {
       [self mbProgress:@"Invalid Credentials"];
   }
    
}
- (IBAction)forgotPasswordButtonAction:(id)sender {
   
//    if (forgotPasswordView == nil)
//    {
//        forgotPasswordView = [[ForgotPasswordView alloc] init];
//    }
//    
//    [forgotPasswordView showView];
  [self mbProgress:@"Currently can't access"];

}

- (IBAction)facebookLoginButtonAction:(id)sender {

     [self mbProgress:@"Currently can't access"];
    //    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login
//     logInWithReadPermissions: @[@"public_profile",@"email",@"user_friends"]
//     fromViewController:self
//     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         if (error) {
//             NSLog(@"Process error");
//         } else if (result.isCancelled) {
//             NSLog(@"Cancelled");
//         } else {
//             NSLog(@"Logged in");
//             [self loginpressfacebookButtonForDetails];
//         }
//     }];
}

-(void)loginpressfacebookButtonForDetails
{
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields": @"id,name,email,gender,hometown,languages,location"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
    
//                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                 [defaults setObject:[result objectAtIndex:1] forKey:UserName_KEY];
//                 [defaults setObject:[result objectAtIndex:2] forKey:UserEmail_KEY];
//                 [defaults synchronize];
                 [self performSegueWithIdentifier:@"logintothanku" sender:self];
//             }
//         }];
//    }

}

-(void)callApiForLogin
{
    NSString *urlString =[NSString stringWithFormat:@"%@%@",pBaseUrl,pLoginUrl];
    NSString *parameter = @"{\"request\":{\"email\":\"admin@vmokshagroup.com\",\"password\":\"Power@123\"}}";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [postman post:urlString withParameter:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
         [self parsingLoginResponseMethod:responseObject];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"success");
    }
        failour:^(NSURLSessionDataTask *task, NSError *error) {
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     NSLog(@"failour");
    }];
}
-(void)parsingLoginResponseMethod :(NSDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSDictionary *responseDictionary = responseDict;
    if ([responseDictionary[@"success"] boolValue]) {
        NSDictionary *viewModelDict =responseDictionary[@"ViewModel"];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:viewModelDict[@"authToken"] forKey:pAutToken];
    [self performSegueWithIdentifier:@"logintothanku" sender:self];
       }
 }
- (BOOL)validateLoginFields
{
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    BOOL goodToGo = YES;
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    if (userName.length == 0)
    {
        goodToGo = NO;
        [mutableString appendString:@"Email Id is required"];
    }
   if (password.length == 0)
    {
        goodToGo = NO;
        if (mutableString.length>0) {
             [mutableString appendString:@"\nPassword is required"];
        }
       else
       {
       [mutableString appendString:@"Password is required"];
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

- (void)mbProgress:(NSString*)message
{
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
