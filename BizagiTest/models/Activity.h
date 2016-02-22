/*!
 @header Activity.h
 @brief File header that represents an activity model in the app.

 File header that represents an activity model in the app.
 
 @author Juan
 @copyright Copyright © 2016 juansmacias. All rights reserved.
 @version 0.1
 */

#import <Foundation/Foundation.h>

@interface Activity : NSObject

/*! Constant defining activity's accepted state. */
extern NSString*const ACCEPTED_STATE;
/*! Constant defining activity's rejected state. */
extern NSString*const REJECTED_STATE;

/*! Property that stores the id of the process associated */
@property (strong, nonatomic) NSString* processId;

/*! Property that stores the name of the process associated */
@property (strong, nonatomic) NSString* process;

/*!  Property that stores the id of the actitity */
@property (strong, nonatomic) NSString* activityId;

/*!  Property that stores the name of the activity */
@property (strong, nonatomic) NSString* activity;

/*!  Property that stores the date that the activity was created */
@property (strong, nonatomic) NSDate* requestDate;

/*!  Property that stores the name of the employee that created the activity */
@property (strong, nonatomic) NSString* employee;

/*!  Property that stores the start date of the vacations */
@property (strong, nonatomic) NSDate* beginDate;

/*!  Property that stores the end date of the vacations */
@property (strong, nonatomic) NSDate* endDate;

/*!  Property that stores the date of the last vactions of the employee */
@property (strong, nonatomic) NSDate* lastVacationOn;

/*!  Property that stores the state of approval of the activity */
@property (strong,nonatomic) NSString* approved;

/*!
 @brief Init method to create and configurate a new Activity.
 @param processIDP Id of the associated process.
 @param processP Name of the associated process.
 @param activityIDP Id of the activity.
 @param activityP Name of the activity.
 @param requestDateP Request date of the activity.
 @param employeeP Name of the employee.
 @param beginDateP Vacations begin date.
 @param endDateP Vacations end date.
 @param lastVacationOnP Last vacation date.
 @param approvedP State of the activity.
 @return Activity Returns the new Activity objectß
*/

-(id) initConParametos:(NSString*)processIDP withProcess:(NSString*)processP withActivityID:(NSString*) activityIDP withActivity:(NSString*)activityP withRequestDate: (NSDate*)requestDateP withEmployee:(NSString*) employeeP withBeginDate:(NSDate*) beginDateP withEndDate:(NSDate*)endDateP withLastVacations:(NSDate*)lastVacationOnP withAproval:(NSString*)approvedP;

/*!
 @brief Method used to accept an Activity.
 */

-(void) acceptActivity;


/*!
 @brief Method used to reject an Activity.
 */
-(void) rejectActivity;

@end
