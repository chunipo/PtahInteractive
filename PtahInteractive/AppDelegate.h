//
//  AppDelegate.h
//  PtahInteractive
//
//  Created by ptah on 16/8/4.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,assign)BOOL isLogin;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

