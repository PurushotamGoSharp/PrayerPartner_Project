//
//  LetsUspraySubCatViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "LetsUspraySubCatViewController.h"
#import "LetsPraySubCatModelClass.h"
#import "PlayingListViewController.h"
#import "CustomNavController.h"
#import "Postman.h"
#import "Constant.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
@interface LetsUspraySubCatViewController ()
{
    LetsPraySubCatModelClass *scModel;
    NSMutableArray *tableData;
    NSIndexPath *indexpath;
    Postman *postman;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrantofView;



@end

@implementation LetsUspraySubCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDel =(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.isLogin = NO;
    
    postman =[[Postman alloc]init];
    tableData =[[NSMutableArray alloc]init];
    [self callApiForCategory];
    self.backgroundImage.image =[UIImage imageNamed:self.lpModel.backGroundImage];
    CGFloat size = [self tableViewHeight];
    self.heightConstrantofView.constant = size+18;
   
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CustomNavController *customNav = (CustomNavController *)self.navigationController;
    [customNav showMenuItem];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return tableData.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cellidentifier" forIndexPath:indexPath];
    scModel =tableData[indexPath.row];
    UILabel *label =(UILabel *)[cell viewWithTag:501];
    label.text = scModel.SubCattitle;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([scModel.SubCattitle isEqualToString:@"Physical Healing"]||[scModel.SubCattitle isEqualToString:@"Anxiety"]||[scModel.SubCattitle isEqualToString:@"Family"]){
        label.textColor = [UIColor lightGrayColor];

    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  scModel =tableData[indexPath.row];
    if ([scModel.SubCattitle isEqualToString:@"Physical Healing"]||[scModel.SubCattitle isEqualToString:@"Anxiety"]||[scModel.SubCattitle isEqualToString:@"Family"]){
        
    } else {
         [self performSegueWithIdentifier:@"SubCategoryToplayinglist" sender:indexPath];
    }
    
   
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SubCategoryToplayinglist"])  {
        indexpath = sender;
        PlayingListViewController *playing = segue.destinationViewController;
        playing.lsModel = tableData[indexpath.row];
    }


}

// table view height
- (CGFloat)tableViewHeight
{
    [self.tableView layoutIfNeeded];
    return [self.tableView contentSize].height;


}

-(void)callApiForCategory
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Subcategory"
                                                     ofType:@"json"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSData *rssponseData =[content dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSDictionary *jsonDict =[NSJSONSerialization JSONObjectWithData:rssponseData options:kNilOptions error:nil];
    [self parsingresponseDictionary:jsonDict];
 [self.tableView reloadData];
    
//    NSString *urlString =[NSString stringWithFormat:@"%@%@",pBaseUrl,pSubCategory];
//    NSString *parameter = [NSString stringWithFormat:@"{\"request\":{\"categoryCode\": \"%@\"}}",self.lpModel.categoryCode];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//[postman post:urlString withParameter:parameter success:^(NSURLSessionDataTask *operation, id responseObject) {
//   [self parsingresponseDictionary:responseObject];
//    [self.tableView reloadData];
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//} failour:^(NSURLSessionDataTask *operation, NSError *error) {
// [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//}];
//
}

-(void)parsingresponseDictionary:(NSDictionary *)responseDict
{
    NSArray *responseArr =responseDict[@"ViewModels"];
    for (NSDictionary *adict in responseArr) {
        if ([adict[@"categoryCode"] isEqualToString:self.lpModel.categoryCode]) {
            scModel =[[LetsPraySubCatModelClass alloc]init];
            scModel.SubCattitle = adict[@"name"];
            scModel.backgroundImageName = adict[@"background"];
            scModel.subCatCode = adict[@"code"];
            [tableData addObject:scModel];
        }
    }


}








-(void)healthLocalData
{
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Balance";
    scModel.backgroundImageName = @"BalanceBackground";
    [tableData addObject:scModel];
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Physical Healing";
    scModel.backgroundImageName = @"";
    [tableData addObject:scModel];
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Anxiety";
    scModel.backgroundImageName = @"";
    [tableData addObject:scModel];
}

-(void)fulimentLocalData
{
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Guidance";
    scModel.backgroundImageName = @"GuidanceBackground";
    [tableData addObject:scModel];
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Revelation";
    scModel.backgroundImageName = @"RevelationBackground";
    [tableData addObject:scModel];
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Purpose";
    scModel.backgroundImageName = @"PurposeBackground";
    [tableData addObject:scModel];
}



-(void)relationshipLocalData
{
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Marriage + Love";
    scModel.backgroundImageName = @"";
    [tableData addObject:scModel];
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Love";
    scModel.backgroundImageName = @"Love";
    [tableData addObject:scModel];
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Family";
    scModel.backgroundImageName = @"";
    [tableData addObject:scModel];
    
}
-(void)generalLocalData
{
    scModel =[[LetsPraySubCatModelClass alloc]init];
    scModel.SubCattitle = @"Revelation";
    scModel.backgroundImageName = @"RevelationBackground";
    [tableData addObject:scModel];
}





@end
