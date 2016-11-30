//
//  Collect.h
//  PtahInteractive
//
//  Created by ptah on 16/8/26.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Collect : NSManagedObject
@property(nonatomic,retain)NSString *displayName;

@property(nonatomic,retain)NSString *favorite;

@property(nonatomic,retain)NSString *fenbianP;
@property(nonatomic,retain)NSString *fileName;

@property(nonatomic,retain)NSString *size;

@property(nonatomic,retain)NSString *type;

@end
