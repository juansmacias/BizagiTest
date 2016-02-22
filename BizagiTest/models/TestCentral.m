/*!
 @class TestCentral.m
 
 @brief File that acts has singleton class to managed all models.
 
 File that acts has singleton class to managed all models. For this particular test we will manage only one process and all it's activities.
 
 @author Juan
 @copyright Copyright © 2016 juansmacias. All rights reserved.
 @version 0.1
 
 */

#import "TestCentral.h"

@implementation TestCentral

@synthesize activities = _activities;

static NSString* const BASE_URL_SERVER = @"http://private-87e27-testbizagi.apiary-mock.com";

static int const TIMEOUT_TIME = 60;

NSString* const FILE_NAME_ACTIVITIES = @"AllActivities";

static TestCentral* instance = nil;

+ (TestCentral*) getInstance
{
    if (instance==nil) {
        instance = [[TestCentral alloc]init];
        [instance initialize];
    }
    return instance;
}

-(void)initialize
{
    NSArray *pathDocuments = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *pathExistingJson =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Preference/%@.json",FILE_NAME_ACTIVITIES]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathExistingJson]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:pathExistingJson error:nil];
        
        NSError *createDirectortError;
        NSString *rutaPlistDirectorio =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:@"Preference"];
        [[NSFileManager defaultManager] createDirectoryAtPath:rutaPlistDirectorio withIntermediateDirectories:NO attributes:nil error:&createDirectortError];
        
        NSString *jsonActivitiesDataPath = [[NSBundle mainBundle] pathForResource:FILE_NAME_ACTIVITIES ofType:@"json"];
        NSData *jsonActivityData=[[NSFileManager defaultManager] contentsAtPath:jsonActivitiesDataPath];
        
        [[NSFileManager defaultManager] createFileAtPath:pathExistingJson contents:jsonActivityData attributes:nil];
    }
    
}

- (void) loadLocalActivities:(NSString*)nameFile
{
    self.activities = [[NSMutableArray alloc]init];
    
    NSArray *pathDocuments = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *pathExistingJson =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Preference/%@.json",nameFile]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathExistingJson]) {
        
        NSError* errorJsonSerialization;
        NSData *jsonActivityData=[[NSFileManager defaultManager] contentsAtPath:pathExistingJson];
        NSArray* jsonActivityArry = [NSJSONSerialization JSONObjectWithData:jsonActivityData options:kNilOptions error:&errorJsonSerialization];
        if (errorJsonSerialization==nil) {
            for (NSDictionary* activityJson in jsonActivityArry) {
                [self.activities addObject:[self jsonToActivity:activityJson]];
            }
        }
        else
            [NSException raise:@"error loading JSON file" format:@"%@",errorJsonSerialization.description];
    }
    else{
        [NSException raise:@"error loading JSON file" format:@""];
    }
    
}

- (BOOL) loadServerActivities
{
    self.activities = [[NSMutableArray alloc]init];
    
    NSString* completeUrlStr = [NSString stringWithFormat:@"%@/actividades",BASE_URL_SERVER];
    dispatch_semaphore_t semaphoreQueue = dispatch_semaphore_create(0);
    BOOL completedServerTask = NO;
    
    NSURL* url = [NSURL URLWithString:completeUrlStr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *responseData,
                                NSURLResponse *urlResponse,
                                NSError *error)
                {
                    if (error==nil) {
                        error =nil;
                        
                        
                        NSArray *pathDocuments = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
                        NSString *pathExistingJson =  [[pathDocuments objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Preference/%@.json",FILE_NAME_ACTIVITIES]];
                        [[NSFileManager defaultManager] removeItemAtPath:pathExistingJson error:nil];
                        [[NSFileManager defaultManager] createFileAtPath:pathExistingJson contents:responseData attributes:nil];
                        
                        NSArray* jsonActivityArry = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                        if (error==nil) {
                            for (NSDictionary* activityJson in jsonActivityArry) {
                                [self.activities addObject:[self jsonToActivity:activityJson]];
                            }
                        }
                        else
                            [NSException raise:@"error downloading JSON file from server" format:@""];
                    }
                    else
                        [NSException raise:@"error downloading JSON file from server" format:@""];
                    
                    dispatch_semaphore_signal(semaphoreQueue);

                }] resume];
    
    dispatch_semaphore_wait(semaphoreQueue, dispatch_time(DISPATCH_TIME_NOW,TIMEOUT_TIME*NSEC_PER_SEC));
    
    if([self.activities count]>0)
        completedServerTask = YES;
    else
        [self loadLocalActivities:FILE_NAME_ACTIVITIES];

    return completedServerTask;
}

-(NSArray*)getAllActivities
{
    return self.activities;
}

-(Activity*)getActivityByID:(NSString*)idActivityStr
{
    BOOL activityFound = NO;
    Activity* activityFoundObj =nil;
    for (int i =0; i <[self.activities count]&&!activityFound; i++) {
        Activity* current = [self.activities objectAtIndex:i];
        if ([current.activityId isEqualToString:idActivityStr])
            {
                activityFound = YES;
                activityFoundObj =current;
            }
    }
    return activityFoundObj;
}


-(void) acceptActivity:(NSString*)idActivityStr
{
    Activity* activityFoundObj = [self getActivityByID:idActivityStr];
    if (activityFoundObj==nil)
        [NSException raise:@"Activity not found." format:@"Activity with id %@ not found",idActivityStr];
    else
        [activityFoundObj acceptActivity];
}

-(void) rejectActivity:(NSString*)idActivityStr
{
    Activity* activityFoundObj = [self getActivityByID:idActivityStr];
    if (activityFoundObj==nil)
        [NSException raise:@"Activity not found." format:@"Activity with id %@ not found",idActivityStr];
    else
        [activityFoundObj rejectActivity];
}

-(Activity*) jsonToActivity:(NSDictionary*) activityJson
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd"];
    NSDate* requestDate = [dateFormat dateFromString:[activityJson objectForKey:@"requestDate"]];
    NSDate* beginDate = [dateFormat dateFromString:[activityJson objectForKey:@"beginDate"]];
    NSDate* endDate = [dateFormat dateFromString:[activityJson objectForKey:@"endDate"]];
    NSDate* lastVacationOn = [dateFormat dateFromString:[activityJson objectForKey:@"lastVacationOn"]];
    
   return [[Activity alloc] initConParametos:[activityJson objectForKey:@"processId"] withProcess:[activityJson objectForKey:@"process"] withActivityID:[activityJson objectForKey:@"activityId"] withActivity:[activityJson objectForKey:@"activity"] withRequestDate: requestDate withEmployee:[activityJson objectForKey:@"employee"] withBeginDate:beginDate withEndDate:endDate withLastVacations:lastVacationOn withAproval:[activityJson objectForKey:@"approved"]];
}

-(int) numberDaysFromBeginDate:(NSDate*)beginDate andEndDate:(NSDate*)endDate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:beginDate toDate:endDate options:0];
    NSInteger numberDaysInteger = [components day];
    return (int)numberDaysInteger;
}

@end
