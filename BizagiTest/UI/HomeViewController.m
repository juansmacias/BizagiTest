//
//  HomeViewController.m
//  BizagiTest
//
//  Created by Juan on 20/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import "HomeViewController.h"
#import "Reachability.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


@synthesize activitiesArry = _activitiesArry;

- (void)viewDidLoad {
    [super viewDidLoad];
    TestCentral* testCentral = [TestCentral getInstance];
    @try {

        self.tblActivities.dataSource = self;
        self.tblActivities.delegate = self;
        [self.tblActivities.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.tblActivities.layer setBorderWidth:1.0f];
        
        Reachability *networkReachability= [Reachability reachabilityForInternetConnection];
        NetworkStatus status = [networkReachability currentReachabilityStatus];
        if (status == NotReachable)
        {
            [testCentral loadLocalActivities:FILE_NAME_ACTIVITIES];
            self.activitiesArry = [testCentral getAllActivities];
            
            [self showInformatationAlertView:@"No Internet Access" withMessage:@"You don't have internet access. We will load the activities that are stored locally. To get the latest version of activities, please connect to internet and restart the app."];
        }
        else
        {
            BOOL completionServer = [testCentral loadServerActivities];
            if (completionServer==NO) {
                [testCentral loadLocalActivities:FILE_NAME_ACTIVITIES];
                self.activitiesArry = [testCentral getAllActivities];
                [self showInformatationAlertView:@"No Internet Access" withMessage:@"You don't have internet access. We will load the activities that are stored locally. To get the latest version of activities, please connect to internet and restart the app."];
            }
            self.activitiesArry = [testCentral getAllActivities];
        }
    }
    @catch (NSException *exception) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error Starting up" message:[NSString stringWithFormat:@"We found an %@. We will restart the app.",exception.name] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* alertAction)
                                      {
                                          [[TestCentral getInstance] initialize];
                                      }];
        [alertController addAction:alertAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.activitiesArry count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityTableViewCell* cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityTableViewCell" owner:self options:nil] objectAtIndex:0];
    Activity* activityObj = [self.activitiesArry objectAtIndex:indexPath.row];
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy'-'MM'-'dd"];
    NSString* beginDateStr = [formater stringFromDate:activityObj.beginDate];
    NSString* endDateStr = [formater stringFromDate:activityObj.endDate];
    NSString* vacationDaysStr = [NSString stringWithFormat:@"%d",[[TestCentral getInstance] numberDaysFromBeginDate:activityObj.beginDate andEndDate:activityObj.endDate]];
    [cell configureCellWithEmployee:activityObj.employee withBeginDate:beginDateStr withEndDate:endDateStr withVacationDays:vacationDaysStr withApproval:activityObj.approved];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Activity* activityObj = [self.activitiesArry objectAtIndex:indexPath.row];
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Vacation's Aproval" message:[NSString stringWithFormat:@"What do you what to do with this %@'s vacations?", activityObj.employee ] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertActionAccepted = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction * alertAction)
                            {
                                [[TestCentral getInstance] acceptActivity:activityObj.activityId];
                                [tableView reloadData];
                            }];
    [alertController addAction:alertActionAccepted];
    UIAlertAction* alertActionRejected = [UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * alertAction)
                                          {
                                              [[TestCentral getInstance] rejectActivity:activityObj.activityId];
                                              [tableView reloadData];
                                          }];
    [alertController addAction:alertActionRejected];
    UIAlertAction* alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * alertAction)
                                          {
                                              
                                          }];
    [alertController addAction:alertActionCancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) showInformatationAlertView:(NSString*)alertTitleStr withMessage:(NSString*)alertMessageStr
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:alertTitleStr message:alertMessageStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* alertAction){}];
    [alertController addAction:alertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
