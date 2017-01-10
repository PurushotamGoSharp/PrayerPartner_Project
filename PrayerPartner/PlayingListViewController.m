//
//  PlayingListViewController.m
//  PrayerPartner
//
//  Created by Saurabh on 2/22/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "PlayingListViewController.h"
#import "PrayListModel.h"
#import "PrayerLandingViewController.h"
#import "CustomNavController.h"

@interface PlayingListViewController ()
{
    NSMutableArray *tableData;
//    PrayListModel *prayModel;
    NSIndexPath *selectedIndexPath;
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     tableData =[[NSMutableArray alloc]init];
    
   
    self.tableView.estimatedRowHeight =44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
   
 //[self localdataControll];
    
    CustomNavController *customNav = (CustomNavController *)self.navigationController;
    [customNav hideMenuItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   [self callApiForPrayerList];
    self.backgroundImage.image =[UIImage imageNamed:self.lsModel.backgroundImageName];
    
    NSLog(@"Viewconrollers = %@", self.navigationController.viewControllers);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)localdataControll
{
    if ([self.lsModel.SubCattitle isEqualToString:@"Balance"]) {
        [self banalceData];
    }
    else if ([self.lsModel.SubCattitle isEqualToString:@"Guidance"]){
     
        [self GuidanceData];
    }
    else if ([self.lsModel.SubCattitle isEqualToString:@"Revelation"]){
        [self RevelationData];
    }
    else if ([self.lsModel.SubCattitle isEqualToString:@"Purpose"]){
        [self PurposeData];
    }

    else if ([self.lsModel.SubCattitle isEqualToString:@"Love"]){
        [self loveData];
    }
   
    [self.tableView reloadData];
}

- (IBAction)BackButtonAction:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

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
    
    PrayListModel *prayModel = tableData[indexPath.row];
    UIButton *startButton =(UIButton *)[cell viewWithTag:312];
    [[startButton layer] setBorderWidth:2.0f];
    [[startButton layer] setBorderColor:[UIColor grayColor].CGColor];
    UILabel *titlelabel =(UILabel *)[cell viewWithTag:101];
    
    NSString *spaceString =[NSString stringWithFormat:@" %@",prayModel.prayerAuthor];
    NSString *prayerWithName = [prayModel.prayerName stringByAppendingString:spaceString];
   
    
    NSString *prayerWithNameDuration =[prayerWithName stringByAppendingString:prayModel.prayerDuration];
    
    titlelabel.attributedText = [self customizelabelString:prayerWithNameDuration andlength:[prayModel.prayerName length]];
    
//    if ([selectedIndexPath isEqual:indexPath]) {
//    titlelabel.textColor =[UIColor whiteColor];
//    } else {
//        
//        titlelabel.textColor =[UIColor lightGrayColor];
//    }
    
    if (indexPath.row==0||[prayModel.prayerName isEqualToString:@"A Wife's Prayer for Husband"]) {
        titlelabel.textColor =[UIColor whiteColor];
    }
    else
    {
    titlelabel.textColor =[UIColor lightGrayColor];
        [startButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        startButton.enabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([selectedIndexPath isEqual:indexPath])
//    {
//        selectedIndexPath = nil;
//    }else
//    {
//        selectedIndexPath = indexPath;
//    }
//    [self.tableView reloadData];
    PrayListModel *prayModel =tableData[indexPath.row];
   
    if (indexPath.row == 0 ||[prayModel.prayerName isEqualToString:@"A Wife's Prayer for Husband"]) {
       [self performSegueWithIdentifier:@"listTolandingPage" sender:indexPath];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"listTolandingPage"])  {
        selectedIndexPath = sender;
        PrayerLandingViewController *prayLanding = segue.destinationViewController;
        prayLanding.prayModel = tableData[selectedIndexPath.row];
    } else if ([segue.identifier isEqualToString:@"buttonIdentifier"]) {
        PrayerLandingViewController *prayLanding = segue.destinationViewController;
        prayLanding.prayModel = tableData[selectedIndexPath.row];

    }
}

-(NSMutableAttributedString *)customizelabelString:(NSString *)string andlength:(NSInteger)length
{

    NSString *prayerName = string;
    

    NSMutableAttributedString *attString =[[NSMutableAttributedString alloc]
                                           initWithString:prayerName];
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont fontWithName:@"HelveticaNeue-Bold" size:15]
                      range: NSMakeRange(0,length)];
    
    
    return attString;
}
//Helvetica Neue Bold 20.0

-(void)callApiForPrayerList
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"SubSubCategory"
                                                     ofType:@"json"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSData *rssponseData =[content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict =[NSJSONSerialization JSONObjectWithData:rssponseData options:kNilOptions error:nil];
    [self parsingresponseDictionary:jsonDict];
    
   


}

-(void)parsingresponseDictionary:(NSDictionary *)responseDict
{
    
    NSArray *responseArr =responseDict[@"ViewModels"];
    for (NSDictionary *adict in responseArr) {
       // NSLog(@"%@",self.lsModel.subCatCode);
        if ([adict[@"subCategoryCode"]isEqualToString:self.lsModel.subCatCode]) {
            PrayListModel *prayModel =[[PrayListModel alloc]init];
            prayModel.prayerName = adict[@"name"];
            prayModel.prayerAuthor = adict[@"authorName"];
            prayModel.prayerDuration = adict[@"prayerDuration"];
            prayModel.prayAlongUrl = adict[@"prayalongurl"];
            prayModel.prayContinousUrl = adict[@"prayContinous"];
            prayModel.prayerScripture = adict[@"scriptures"];
            prayModel.scriptureImage = adict[@"scriptbackground"];
             prayModel.prayerBackgroundImg = adict[@"prayerbackground"];
            
            [tableData addObject:prayModel];
        }
    
    }
    
}

-(void)MarrageData
{
    PrayListModel *prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"A Husband's Prayer for his Marriage and Wife ";
    prayModel.prayerAuthor = @"by Bill Swann.....";
    prayModel.prayerDuration =@"2:00";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"A Wife's Prayer For Husband ";
    prayModel.prayerAuthor = @"by kimnenly.....";
    prayModel.prayerDuration =@"1.07";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Single, Never Married and Ready for that to End ";
    prayModel.prayerAuthor = @"by Mary claire.....";
    prayModel.prayerDuration =@"1.23";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Bless Our Engagement ";
    prayModel.prayerAuthor = @"by kelli.....";
    prayModel.prayerDuration =@"1.32";
    [tableData addObject:prayModel];

}
-(void)banalceData
{
    PrayListModel *prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Prayer to God of Peace, Order,Stability & Balance ";
    prayModel.prayerAuthor = @"by Kelli.....";
    prayModel.prayerDuration =@"2.08";
    [tableData addObject:prayModel];

    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"I Want to Feel Whole Again ";
    prayModel.prayerAuthor = @"by sharon.....";
    prayModel.prayerDuration =@"1:34";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Prayer to Stay Connect to My Source,God ";
    prayModel.prayerAuthor = @"by Betty.....";
    prayModel.prayerDuration =@"1:09";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Be the Greate Editor of My Life ";
    prayModel.prayerAuthor = @"by Bill.....";
    prayModel.prayerDuration =@"1:57";
    [tableData addObject:prayModel];

}

-(void)loveData
{
    PrayListModel *prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"I Want to Experience Your Love,God ";
    prayModel.prayerAuthor = @"by Arlene.....";
    prayModel.prayerDuration =@"1:49";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Hearbreak ";
    prayModel.prayerAuthor = @"by Rachelle.....";
    prayModel.prayerDuration =@"1:22";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Searching for God's best for Me ";
    prayModel.prayerAuthor = @"by Kimberly.....";
    prayModel.prayerDuration =@"2:11";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"My Prayer for Purity as I Date ";
    prayModel.prayerAuthor = @"by Jennette.....";
    prayModel.prayerDuration =@"1:21";
    [tableData addObject:prayModel];

}

-(void)PurposeData
{
    PrayListModel *prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"I Want to Experience Your Love,God ";
    prayModel.prayerAuthor = @"by Arlene.....";
    prayModel.prayerDuration =@"1:49";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Hearbreak ";
    prayModel.prayerAuthor = @"by Rachelle.....";
    prayModel.prayerDuration =@"1:22";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Searching for God's best for Me ";
    prayModel.prayerAuthor = @"by Kimberly.....";
    prayModel.prayerDuration =@"2:11";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"My Prayer for Purity as I Date ";
    prayModel.prayerAuthor = @"by Jennette.....";
    prayModel.prayerDuration =@"1:21";
    [tableData addObject:prayModel];
    
    
}

-(void)RevelationData
{
    PrayListModel *prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"I Want to Experience Your Love,God ";
    prayModel.prayerAuthor = @"by Arlene.....";
    prayModel.prayerDuration =@"1:49";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Hearbreak ";
    prayModel.prayerAuthor = @"by Rachelle.....";
    prayModel.prayerDuration =@"1:22";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Searching for God's best for Me ";
    prayModel.prayerAuthor = @"by Kimberly.....";
    prayModel.prayerDuration =@"2:11";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"My Prayer for Purity as I Date ";
    prayModel.prayerAuthor = @"by Jennette.....";
    prayModel.prayerDuration =@"1:21";
    [tableData addObject:prayModel];
    
}
-(void)GuidanceData
{
    PrayListModel *prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"I Want to Experience Your Love,God ";
    prayModel.prayerAuthor = @"by Arlene.....";
    prayModel.prayerDuration =@"1:49";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Hearbreak ";
    prayModel.prayerAuthor = @"by Rachelle.....";
    prayModel.prayerDuration =@"1:22";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"Searching for God's best for Me ";
    prayModel.prayerAuthor = @"by Kimberly.....";
    prayModel.prayerDuration =@"2:11";
    [tableData addObject:prayModel];
    
    prayModel =[[PrayListModel alloc]init];
    prayModel.prayerName = @"My Prayer for Purity as I Date ";
    prayModel.prayerAuthor = @"by Jennette.....";
    prayModel.prayerDuration =@"1:21";
    [tableData addObject:prayModel];
    
    
}






@end
