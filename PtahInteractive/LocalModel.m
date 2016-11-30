//
//  LocalModel.m
//  PtahInteractive
//
//  Created by ptah on 16/9/1.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "LocalModel.h"
#import "Local.h"

@implementation LocalModel

-(void)setLocalmodel:(Local *)localmodel{
    _localmodel = localmodel;
    
   // self.originalImg = localmodel.originalImg;
    
    self.imgName = localmodel.imgName;
    
    self.miniImg =localmodel.miniImg;
    
    self.originalpic = localmodel.originalpic;

}



@end
