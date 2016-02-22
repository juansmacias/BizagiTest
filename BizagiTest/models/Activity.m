//
//  Activity.m
//  BizagiTest
//
//  Created by Juan on 19/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import "Activity.h"

@implementation Activity

NSString*const ACCEPTED_STATE = @"accepted";
NSString*const REJECTED_STATE = @"rejected";

@synthesize processId,process,activityId,activity,requestDate,employee,beginDate,endDate,lastVacationOn;


-(id) initConParametos:(NSString*)processIDP withProcess:(NSString*)processP withActivityID:(NSString*) activityIDP withActivity:(NSString*)activityP withRequestDate: (NSDate*)requestDateP withEmployee:(NSString*) employeeP withBeginDate:(NSDate*) beginDateP withEndDate:(NSDate*)endDateP withLastVacations:(NSDate*)lastVacationOnP withAproval:(NSString*)approvedP
{
    self = [super init];
    if(self)
    {
        self.processId =processIDP;
        self.process = processP;
        self.activityId = activityIDP;
        self.activity = activityP;
        self.requestDate = requestDateP;
        self.employee = employeeP;
        self.beginDate =beginDateP;
        self.endDate = endDateP;
        self.lastVacationOn = lastVacationOnP;
        self.approved = approvedP;
    }
    return self;
}

-(void) acceptActivity
{
    self.approved = ACCEPTED_STATE;
}

-(void) rejectActivity
{
    self.approved = REJECTED_STATE;
}

@end
