/*!
 @header TestCentral.h
 
 @brief File that acts has singleton header to managed all models.
 
 File that acts has singleton header to managed all models. For this particular test we will manage only one process and all it's activities.
 
 @author Juan
 @copyright Copyright © 2016 juansmacias. All rights reserved.
 @version 0.1
 
 */

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface TestCentral : NSObject

/*! Constat that stores the name of the files that contains the activities information. */
extern NSString* const FILE_NAME_ACTIVITIES;

/*! Property that holds all the activities of the process */
@property (strong,nonatomic) NSMutableArray* activities;


/*!
 @brief Getter method to the singleton instance.
 @return TestCentral Instance object of the class.
 */
+ (TestCentral*) getInstance;

/*!
 @brief Method to initialize the singleton class
 */
-(void)initialize;

/*!
 @brief Method used to load all activities to the app from local file.
 @param nameFile Name of the file where the activities will be loaded.
 */
- (void) loadLocalActivities:(NSString*)nameFile;

/*!
 @brief Method used to load all activities to the app from server
 @param nameFile Name of the file where the activities will be loaded.
 @return BOOL boolean to determin whether or not the activities from the server were loaded correctly 
 */
- (BOOL) loadServerActivities;

/*!
 @brief Method that returns all activities of the process.
 @return NSSArray Array with all the activity objects.
 */
-(NSArray*)getAllActivities;

/*!
 @brief Method that returns an activity by it's ID.
 @param idActivityStr Id of the activity to be found.
 @return Activity The wanted Activity object.
 */
-(Activity*)getActivityByID:(NSString*)idActivityStr;

/*!
 @brief Method used to accept an Activity by it's ID.
 @param idActivityStr Id of the activity to be accepted.
 */
-(void) acceptActivity:(NSString*)idActivityStr;

/*!
 @brief Method used to reject an Activity by it's ID.
 @param idActivityStr Id of the activity to be rejected.
 */
-(void) rejectActivity:(NSString*)idActivityStr;

/*!
@brief Method used to transform a json activity from the backend to an Activity object.
@param activityJson Activity in json format.
@return Activity Activity object transformed.
*/
-(Activity*) jsonToActivity:(NSDictionary*) activityJson;

/*!
 @brief Method used to calculate the number of vacations day from it's From-To dates.
 @param beginDate Begin date of vacations.
 @param endDate End date of vacations.
 @return int The numbers of days between the two dates.
 */

-(int) numberDaysFromBeginDate:(NSDate*)beginDate andEndDate:(NSDate*)endDate;

@end
