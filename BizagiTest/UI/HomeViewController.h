//
//  HomeViewController.h
//  BizagiTest
//
//  Created by Juan on 20/02/16.
//  Copyright © 2016 juansmacias. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCentral.h"
#import "ActivityTableViewCell.h"

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

/*! Table View that shows all the activities.*/
@property (strong, nonatomic) IBOutlet UITableView *tblActivities;
@property (strong, nonatomic) IBOutlet UIView *viewGreetings;

/*! Array containing all the activity objects. */
@property (strong,nonatomic) NSArray* activitiesArry;

@end
