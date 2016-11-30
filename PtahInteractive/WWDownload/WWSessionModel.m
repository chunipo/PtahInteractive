//
//  WWSessionModel.m
//  WWDownload
//
//  Created by lilei on 16/7/7.
//  Copyright © 2016年 lilei. All rights reserved.
//

#import "WWSessionModel.h"
#import "WWDownloadManager.h"
@implementation WWSessionModel


- (float)calculateFileSizeInUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3)) { return (float) (contentLength / (float)pow(1024, 3)); }
    else if (contentLength >= pow(1024, 2)) { return (float) (contentLength / (float)pow(1024, 2)); }
    else if (contentLength >= 1024) { return (float) (contentLength / (float)1024); }
    else { return (float) (contentLength); }
}

- (NSString *)calculateUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3)) { return @"GB";}
    else if(contentLength >= pow(1024, 2)) { return @"MB"; }
    else if(contentLength >= 1024) { return @"KB"; }
    else { return @"B"; }
}

+(LKDBHelper*)getUsingLKDBHelper{
    static LKDBHelper* CourseModeldb;
    NSString *path =[NSString stringWithFormat:@"%@/download.db",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    //    NSString *path = [NSString stringWithFormat:@"%@/db/KKDB.db",[CourseSDK getCourseRootPath]];
    CourseModeldb = [[LKDBHelper alloc]initWithDBPath:path];
    return CourseModeldb;
}

+(NSString *)getTableName{
    return @"Course";
}
-(NSString *)filePath{
    return WWFileFullpath(self.url);
}


@end
