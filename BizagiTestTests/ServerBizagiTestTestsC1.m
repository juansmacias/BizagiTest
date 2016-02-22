//
//  ServerBizagiTestTestsC1.m
//  BizagiTest
//
//  Created by Juan on 21/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCentral.h"

@interface ServerBizagiTestTestsC1 : XCTestCase

@end

@implementation ServerBizagiTestTestsC1

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [TestCentral getInstance].activities = [[NSMutableArray alloc]init];
    [super tearDown];
}

- (void)testLoad {
    BOOL resultServer = [[TestCentral getInstance] loadServerActivities];
    
    XCTAssertTrue(resultServer,@"The app could not access the server.");

    TestCentral * testCentral = [TestCentral getInstance];
    XCTAssertEqual(5, (int)[testCentral.activities count],@"The activities were not loaded correctly. Expect: %d Result: %d",5,(int)[testCentral.activities count]);
    
    Activity* activityObj = [testCentral getActivityByID:@"1"];
    XCTAssertEqualObjects(@"Andres Iniesta", activityObj.employee,@"The employee of activity 1 should had been Andres Iniesta and it was %@",activityObj.employee);
    
}


@end
