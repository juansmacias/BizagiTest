//
//  ActivityTableViewCell.m
//  BizagiTest
//
//  Created by Juan on 20/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "Activity.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithEmployee:(NSString*)employeeStr withBeginDate:(NSString*)beginDateStr withEndDate:(NSString*)endDateStr withVacationDays:(NSString*)vDaysStr withApproval:(NSString*)approval
{
    self.lblEmployee.text = employeeStr;
    self.lblBeginDate.text = beginDateStr;
    self.lblEndDate.text = endDateStr;
    self.lblVacationsDays.text = vDaysStr;
    if ([approval isEqualToString:ACCEPTED_STATE]) {
        self.imgApproval.image = [UIImage imageNamed:@"sign-check"];
    }
    else if ([approval isEqualToString:REJECTED_STATE])
    {
        self.imgApproval.image = [UIImage imageNamed:@"sign-error"];
    }
}

@end
