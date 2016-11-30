//
//  Login.h
//  PtahInteractive
//
//  Created by ptah on 16/8/17.
//  Copyright © 2016年 Ptah. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Login : NSManagedObject

@property(nonatomic,retain)NSString *name;

@property(nonatomic,retain)NSString *password;

@property(nonatomic,retain)NSString *email;

@end
