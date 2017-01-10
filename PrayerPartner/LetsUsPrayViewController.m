//
//  LetsUsPrayViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/18/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "LetsUsPrayViewController.h"
#import "LetsPrayModel.h"
#import "LetsUspraySubCatViewController.h"
#import "Postman.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Constant.h"
#import "AppDelegate.h"
@interface LetsUsPrayViewController ()<UITableViewDataSource,UITableViewDelegate>

{

    LetsPrayModel *pModel;
    NSMutableArray *tableArray;
    NSIndexPath *selectedIndex;
    Postman *postman;
}


@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LetsUsPrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
   self.borderView.layer.borderWidth = 2.0f;
    tableArray =[[NSMutableArray alloc]init];
   
    // [self localData];
    
    AppDelegate *appDel =(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.isLogin = NO;
 postman =[[Postman alloc]init];
    
    [self CallApiForgettingCategory];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return tableArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cellidentifier" forIndexPath:indexPath];
    pModel =tableArray[indexPath.row];
    
    UIImageView *img =(UIImageView *)[cell viewWithTag:100];
    UILabel *label =(UILabel *)[cell viewWithTag:101];
    label.text = pModel.title;
    img.image =[UIImage imageNamed:pModel.imageName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self performSegueWithIdentifier:@"letspraytosubCategory" sender:indexPath];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"letspraytosubCategory"]) {
        selectedIndex = sender;
        LetsUspraySubCatViewController *subCat = segue.destinationViewController;
        subCat.lpModel = tableArray[selectedIndex.row];
    
    
    }

}


-(void)CallApiForgettingCategory
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Category"
                                                     ofType:@"json"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSData *rssponseData =[content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict =[NSJSONSerialization JSONObjectWithData:rssponseData options:kNilOptions error:nil];
    [self parsingresponseDictionary:jsonDict];
    
//    NSString *urlString =[NSString stringWithFormat:@"%@%@",pBaseUrl,pCategory];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [postman get:urlString withParameters:kNilOptions success:^(NSURLSessionDataTask *operation, id responseObject) {
//        NSLog(@"Success");
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self parsingresponseDictionary:responseObject];
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        NSLog(@"Failour");
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }];
//    
    


}

-(void)parsingresponseDictionary:(NSDictionary *)responseDict
{
    NSArray *responseArr =responseDict[@"ViewModels"];
    for (NSDictionary *adict in responseArr) {
      pModel =[[LetsPrayModel alloc]init];
        pModel.title = adict[@"name"];
        pModel.imageName = adict[@"iconName"];
        pModel.backGroundImage = adict[@"background"];
        pModel.categoryCode = adict[@"code"];
        [tableArray addObject:pModel];
    }

}





-(void)localData
{
    pModel =[[LetsPrayModel alloc]init];
    pModel.title = @"Fulfillment";
    pModel.imageName = @"fulimenticon";
    pModel.backGroundImage = @"fulementBackgrounf";
    [tableArray addObject:pModel];
    pModel =[[LetsPrayModel alloc]init];
    pModel.title = @"Health";
    pModel.imageName = @"HealthIcon";
     pModel.backGroundImage = @"HealthBackground";
    [tableArray addObject:pModel];
    pModel =[[LetsPrayModel alloc]init];
    pModel.title = @"General";
    pModel.imageName = @"GeneralIcon";
     pModel.backGroundImage = @"generalBackground";
    [tableArray addObject:pModel];
    pModel =[[LetsPrayModel alloc]init];
    pModel.title = @"Relationships";
    pModel.imageName = @"RelationshipIcon";
     pModel.backGroundImage = @"Relationship";
    [tableArray addObject:pModel];

}

@end
