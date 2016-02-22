//
//  BizagiTestTests.m
//  BizagiTestTests
//
//  Created by Juan on 19/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCentral.h"

@interface LocalBizagiTestTestsC1 : XCTestCase

@end

@implementation LocalBizagiTestTestsC1

NSString*const NAME_FILE_CASE1 = @"ActivityC1";

- (void)setUp {
    [super setUp];
    NSArray *pathDocuments = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *pathExistingJson =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Preference/%@.json",NAME_FILE_CASE1]];
    
    NSError *createDirectortError;
    NSString *rutaPlistDirectorio =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:@"Preference"];
    [[NSFileManager defaultManager] createDirectoryAtPath:rutaPlistDirectorio withIntermediateDirectories:NO attributes:nil error:&createDirectortError];
    
    NSString *jsonActivitiesDataPath = [[NSBundle mainBundle] pathForResource:NAME_FILE_CASE1 ofType:@"json"];
    NSData *jsonActivityData=[[NSFileManager defaultManager] contentsAtPath:jsonActivitiesDataPath];
    
    [[NSFileManager defaultManager] createFileAtPath:pathExistingJson contents:jsonActivityData attributes:nil];
    
    [[TestCentral getInstance] loadLocalActivities:NAME_FILE_CASE1];
}

- (void)tearDown {
    [TestCentral getInstance].activities = [[NSMutableArray alloc]init];
    [super tearDown];
}

- (void)testLoad {
    TestCentral * testCentral = [TestCentral getInstance];
    XCTAssertEqual(1, (int)[testCentral.activities count],@"The activities were not loaded correctly. Expect: %d Result: %d",1,(int)[testCentral.activities count]);
    
    Activity* activityObj = [testCentral getActivityByID:@"1"];
    XCTAssertEqualObjects(@"Andres Iniesta", activityObj.employee,@"The employee of activity 1 should had been Andres Iniesta and it was %@",activityObj.employee);
    
}

-(void)testAcceptedActivity
{
    TestCentral * testCentral = [TestCentral getInstance];
    [testCentral acceptActivity:@"1"];
    XCTAssertEqualObjects(ACCEPTED_STATE, [testCentral getActivityByID:@"1"].approved,@"The activity was not marked as accepted.");
}

-(void)testRejectedActivity
{
    TestCentral * testCentral = [TestCentral getInstance];
    [testCentral rejectActivity:@"1"];
    XCTAssertEqualObjects(REJECTED_STATE, [testCentral getActivityByID:@"1"].approved,@"The activity was not marked as rejected.");
}

-(void)testNumberDays
{
    TestCentral * testCentral = [TestCentral getInstance];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd"];
    //Days in same month
    NSDate* fromDate = [dateFormat dateFromString:@"2010-12-02"];
    NSDate* toDate = [dateFormat dateFromString:@"2010-12-21"];
    int daysInt = [testCentral numberDaysFromBeginDate:fromDate andEndDate:toDate];
    XCTAssertEqual(19, daysInt,@"The number of days were not calculated correctly");
    //Two diferent months
    fromDate = [dateFormat dateFromString:@"2010-11-02"];
    toDate = [dateFormat dateFromString:@"2010-12-10"];
    daysInt = [testCentral numberDaysFromBeginDate:fromDate andEndDate:toDate];
    XCTAssertEqual(38, daysInt,@"The number of days were not calculated correctly");
    //Two diferent years
    fromDate = [dateFormat dateFromString:@"2010-12-01"];
    toDate = [dateFormat dateFromString:@"2011-01-15"];
    daysInt = [testCentral numberDaysFromBeginDate:fromDate andEndDate:toDate];
    XCTAssertEqual(45, daysInt,@"The number of days were not calculated correctly");
}

@end
