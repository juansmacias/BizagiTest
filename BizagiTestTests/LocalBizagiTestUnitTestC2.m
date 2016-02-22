//
//  LocalBizagiTestUnitTestC2.m
//  BizagiTest
//
//  Created by Juan on 20/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCentral.h"

@interface LocalBizagiTestUnitTestC2 : XCTestCase

@end

@implementation LocalBizagiTestUnitTestC2

NSString*const NAME_FILE_CASE2 = @"ActivitiesC2";

- (void)setUp {
    [super setUp];
    NSArray *pathDocuments = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *pathExistingJson =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Preference/%@.json",NAME_FILE_CASE2]];
    
    NSError *createDirectortError;
    NSString *rutaPlistDirectorio =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:@"Preference"];
    [[NSFileManager defaultManager] createDirectoryAtPath:rutaPlistDirectorio withIntermediateDirectories:NO attributes:nil error:&createDirectortError];
    
    NSString *jsonActivitiesDataPath = [[NSBundle mainBundle] pathForResource:NAME_FILE_CASE2 ofType:@"json"];
    NSData *jsonActivityData=[[NSFileManager defaultManager] contentsAtPath:jsonActivitiesDataPath];
    
    [[NSFileManager defaultManager] createFileAtPath:pathExistingJson contents:jsonActivityData attributes:nil];
    @try{
        [[TestCentral getInstance] loadLocalActivities:NAME_FILE_CASE2];
    }
    @catch (NSException* exception)
    {
        NSLog(@"Exception: %@ (%@)",exception.name,exception.description);
    }
}

- (void)tearDown {
    [TestCentral getInstance].activities = [[NSMutableArray alloc]init];
    [super tearDown];
}

- (void)testLoad {
    TestCentral * testCentral = [TestCentral getInstance];
    XCTAssertEqual(4, (int)[testCentral.activities count],@"The activities were not loaded correctly. Expect: %d Result: %d",4,(int)[testCentral.activities count]);
    
    Activity* activityObj = [testCentral getActivityByID:@"1"];
    XCTAssertEqualObjects(@"Xavi Hernandez", activityObj.employee,@"The employee of activity 1 should had been Xavi Hernandez and it was %@",activityObj.employee);
    
    activityObj = [testCentral getActivityByID:@"4"];
    XCTAssertEqualObjects(@"Sergio Busquets", activityObj.employee,@"The employee of activity 1 should had been Sergio Busquets and it was %@",activityObj.employee);
}


@end
