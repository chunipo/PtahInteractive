//
//  History.h
//  PtahInteractive
//
//  Created by ptah on 16/8/30.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface History : NSManagedObject
@property(nonatomic,retain)NSString *displayName;

@property(nonatomic,retain)NSString *favorite;

@property(nonatomic,retain)NSString *fenbianP;
@property(nonatomic,retain)NSString *fileName;

@property(nonatomic,retain)NSString *size;

@property(nonatomic,retain)NSString *type;
@end
