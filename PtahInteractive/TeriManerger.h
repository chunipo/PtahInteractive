//
//  TeriManerger.h
//  PtahInteractive
//
//  Created by ptah on 16/8/17.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TeriManerger : NSObject

+ (instancetype)shareManager;

@property(nonatomic,strong)NSManagedObjectContext *context;

@property(nonatomic,strong,readonly)NSManagedObjectModel *model;

@property(nonatomic,strong,readonly)NSPersistentStoreCoordinator *coordintor;

@property(nonatomic,assign)BOOL isLogin;

-(void)saveContext;

-(NSURL *)appDocumentsDirectory;



@end
