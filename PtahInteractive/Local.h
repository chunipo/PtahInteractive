//
//  Local.h
//  PtahInteractive
//
//  Created by ptah on 16/9/1.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Local : NSManagedObject

@property(nonatomic,retain)NSString *imgName;

@property(nonatomic,retain)NSData *miniImg;
@property(nonatomic,retain)NSData *originalImg;

@property(nonatomic,assign)BOOL selectState;//是否选中状态


@property(nonatomic,retain)NSString *originalpic;
@end
