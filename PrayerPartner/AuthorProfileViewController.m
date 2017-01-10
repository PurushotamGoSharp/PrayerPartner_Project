//
//  AuthorProfileViewController.m
//  PrayerPartner
//
//  Created by jenkins on 24/02/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import "AuthorProfileViewController.h"
#import "AuthorProfileModel.h"
#import "DetailAuthorProfile.h"

@interface AuthorProfileViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *borderView;

@end

@implementation AuthorProfileViewController

{
    NSMutableArray *imageArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self imagesSet];
    self.borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.borderView.layer.borderWidth = 2.0f;

    
    
    imageArray = [[NSMutableArray alloc] init];
    [self callApiForAuthorProfiles];


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}



-(NSArray *)imagesSet
{
    imageArray=[[NSMutableArray alloc]init];
   AuthorProfileModel * authorProfileObj=[AuthorProfileModel new];
    authorProfileObj.imageString=@"Authors-Betty";
    authorProfileObj.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ";
    AuthorProfileModel * authorProfileObj1=[AuthorProfileModel new];
    authorProfileObj1.imageString=@"Authors-Bill";
    authorProfileObj1.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj2=[AuthorProfileModel new];
    authorProfileObj2.imageString=@"Authors-Jeanette";
    authorProfileObj2.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj3=[AuthorProfileModel new];
    authorProfileObj3.imageString=@"Authors-Kelli";
    authorProfileObj3.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj4=[AuthorProfileModel new];
    authorProfileObj4.imageString=@"Authors-Kimberly";
    authorProfileObj4.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj5=[AuthorProfileModel new];
    authorProfileObj5.imageString=@"Authors-Marge";
    authorProfileObj5.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj6=[AuthorProfileModel new];
    authorProfileObj6.imageString=@"Authors-MaryClaire";
    authorProfileObj6.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj7=[AuthorProfileModel new];
    authorProfileObj7.imageString=@"Authors-Rachelle";
    authorProfileObj7.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj8=[AuthorProfileModel new];
    authorProfileObj8.imageString=@"Authors-Sharon";
    authorProfileObj8.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj9=[AuthorProfileModel new];
    authorProfileObj9.imageString=@"Authors-Julie";
    authorProfileObj9.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    AuthorProfileModel * authorProfileObj10=[AuthorProfileModel new];
    authorProfileObj10.imageString=@"Authors-Arlene";
    authorProfileObj10.theDescription=@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    [imageArray addObject:authorProfileObj];
    
    imageArray=[NSMutableArray  arrayWithObjects:authorProfileObj,authorProfileObj1,authorProfileObj2,authorProfileObj3,authorProfileObj4,authorProfileObj5,authorProfileObj6,authorProfileObj7,authorProfileObj8,authorProfileObj9,authorProfileObj10, nil];
    
    return imageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return imageArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AuthorProfileModel *mObj=[imageArray objectAtIndex:indexPath.row];
    UIImageView *flagImageView = (UIImageView *)[cell viewWithTag:101];
    flagImageView.image = [UIImage imageNamed:mObj.imageString];
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
            DetailAuthorProfile *dap=[self.storyboard instantiateViewControllerWithIdentifier:@"DAID"];
        dap.authorProfileObj=[imageArray objectAtIndex:indexPath.row];
        [self presentViewController:dap animated:YES completion:nil];
        
  }



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // calcualting the padding from both side in collection view so we put total 64  and -4 is for gap between two cell.
    CGSize returnSize = CGSizeZero;
    returnSize = CGSizeMake((((self.view.frame.size.width-80)/3)), ((self.view.frame.size.width-80)/3));
    return returnSize;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1; // This is the minimum inter item spacing, can be more
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)callApiForAuthorProfiles
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"AuthorProfile"
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
    [imageArray removeAllObjects];
    NSArray *responseArr =responseDict[@"ViewModels"];
    for (NSDictionary *adict in responseArr) {
        AuthorProfileModel * authorProfileObj=[AuthorProfileModel new];
        authorProfileObj.imageString=adict[@"profile"];
        authorProfileObj.theDescription = adict[@"authorDesc"];
        [imageArray addObject:authorProfileObj];
        
    }
    
}



@end
