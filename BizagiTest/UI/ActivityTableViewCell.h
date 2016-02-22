//
//  ActivityTableViewCell.h
//  BizagiTest
//
//  Created by Juan on 20/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

/*! UILabel that represents the employee's name. */
@property (strong, nonatomic) IBOutlet UILabel *lblEmployee;
/*! UILabel that represents the begin date of the vacations. */
@property (strong, nonatomic) IBOutlet UILabel *lblBeginDate;
/*! UILabel that represents the end date of the vacations. */
@property (strong, nonatomic) IBOutlet UILabel *lblEndDate;
/*! UIImageView that shows the state of the activity. */
@property (strong, nonatomic) IBOutlet UIImageView *imgApproval;
/*! UILabel that represents the amount of vacation days.*/
@property (strong, nonatomic) IBOutlet UILabel *lblVacationsDays;

/*!
 @brief Method that configurates the cell to show the information about the activity.
 @param employeeStr Employee's name.
 @param beginDateStr Begin Date.
 @param endDateStr End Date.
 @param vDaysStr Vacations days.
 @param approval Approval State.
 
 */
-(void)configureCellWithEmployee:(NSString*)employeeStr withBeginDate:(NSString*)beginDateStr withEndDate:(NSString*)endDateStr withVacationDays:(NSString*)vDaysStr withApproval:(NSString*)approval;

@end
