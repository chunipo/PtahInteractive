//
//  WWDownloadManager.m
//  WWDownload
//
//  Created by lilei on 16/7/7.
//  Copyright © 2016年 lilei. All rights reserved.
//

#import "WWDownloadManager.h"
#import "SZKNetWorkUtils.h"

@interface WWDownloadManager ()<NSURLSessionDelegate>
/** 保存所有任务(注：用下载地址/后作为key) */
@property (nonatomic, strong) NSMutableDictionary *tasks;
/** 保存所有下载相关信息字典 */
@property (nonatomic, strong) NSMutableDictionary *sessionModels;
/** 所有本地存储的所有下载信息数据数组 */
@property (nonatomic, strong) NSMutableArray *sessionModelsArray;
/** 下载完成的模型数组*/
@property (nonatomic, strong) NSMutableArray *downloadedArray;
/** 下载中的模型数组*/
@property (nonatomic, strong) NSMutableArray *downloadArray;

/**正在下载中的模型数组*/
@property(nonatomic, strong) NSMutableArray *downloadingArray;


@property (nonatomic,strong) LKDBHelper *lkdbhelper;

@property(nonatomic,assign)BOOL iswifi;

@property(nonatomic,assign)NSInteger xinhao;

@end


@implementation WWDownloadManager

#pragma mark - get/set
-(LKDBHelper *)lkdbhelper{
    if (!_lkdbhelper) {
        _lkdbhelper = [WWSessionModel getUsingLKDBHelper];
    }
    return _lkdbhelper;
}


- (NSMutableDictionary *)tasks
{
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

- (NSMutableDictionary *)sessionModels
{
    if (!_sessionModels) {
        _sessionModels = @{}.mutableCopy;
    }
    return _sessionModels;
}


- (NSMutableArray *)sessionModelsArray
{
    if (!_sessionModelsArray) {
        _sessionModelsArray = @[].mutableCopy;
        [_sessionModelsArray addObjectsFromArray:[self getSessionModels]];
    }
    return _sessionModelsArray;
}

- (NSMutableArray *)downloadArray
{
    if (!_downloadArray) {
        _downloadArray = @[].mutableCopy;
        for (WWSessionModel *obj in self.sessionModelsArray) {
            if (![self isCompletion:obj.url]) {
                [_downloadArray addObject:obj];
            }
        }
    }
    return _downloadArray;
}
- (NSMutableArray *)downloadingArray{
    if (!_downloadingArray) {
        _downloadingArray = @[].mutableCopy;
        for (WWSessionModel *obj in self.downloadArray) {
            if (obj.downloadState == DownloadStateLoading) {
                [_downloadingArray addObject:obj];
            }
        }
    }
    return _downloadingArray;
}


- (NSMutableArray *)downloadedArray
{
    if (!_downloadedArray) {
        _downloadedArray = @[].mutableCopy;
        for (WWSessionModel *obj in self.sessionModelsArray) {
            if ([self isCompletion:obj.url]) {
                [_downloadedArray addObject:obj];
            }
        }
    }
    return _downloadedArray;
}

#pragma mark - init

static WWDownloadManager *_downloadManager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _downloadManager = [super allocWithZone:zone];
    });
    
    return _downloadManager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return _downloadManager;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[self alloc] init];
    });
    
    return _downloadManager;
}

/**
 * 读取model
 */
- (NSArray *)getSessionModels
{
    // 文件信息
    NSArray *sessionModels = [WWSessionModel searchWithWhere:nil];
    for (WWSessionModel *model in sessionModels) {
        NSUInteger receivedLength = WWDownloadLength(model.url);
        NSString *receivedSize = [NSString stringWithFormat:@"%.2f %@",
                                  [model calculateFileSizeInUnit:(unsigned long long)receivedLength],
                                  [model calculateUnit:(unsigned long long)receivedLength]];
        model.receivedLength = receivedLength;
        model.receivedSize = receivedSize;
       
            if (model.totalLength && model.receivedLength == model.totalLength) {
                model.downloadState = DownloadStateCompleted;
            }else{
            
                model.downloadState = DownloadStateSuspended;
            }

        model.progressBlock = nil;
        model.stateBlock = nil;
        [self.sessionModels setValue:model forKey:model.url.lastPathComponent];
    }
    
    
    
    return sessionModels;
}


/**
 *  创建缓存目录文件
 */
- (void)createCacheDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:WWCachesDirectory]) {
        [fileManager createDirectoryAtPath:WWCachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

/**
 *  开启任务下载资源
 */
- (void)download:(NSDictionary *)dic progress:(DownloadProgressBlock)progressBlock state:(DownloadStateBlock)stateBlock
{
    
    //判断是否wifi下载的才可以继续
    [SZKNetWorkUtils netWorkState:^(NSInteger netState) {
        switch (netState) {
            case 1:{
                NSLog(@"手机流量上网");
                _iswifi = NO;
                _xinhao = 1;
            }
                break;
            case 2:{
                NSLog(@"WIFI上网");
                _iswifi = YES;
                _xinhao=2;
            }
                break;
            default:{
                NSLog(@"没网");
                _iswifi = NO;
                _xinhao=3;
            }
                break;
        }
    }];

    
    NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    if(([defaults[@"onlyWifi"] isEqualToString:@"YES"]&&_iswifi==YES)||([defaults[@"onlyWifi"] isEqualToString:@"NO"])){
//    下载地址
    NSString *url = dic[@"ResourceUrl"];

    NSLog(@"%@",WWCachesDirectory);
    if (!url) return;
    if ([self isCompletion:url]) {
        stateBlock(DownloadStateCompleted);
        NSLog(@"----该资源已下载完成");
        return;
    }
    
    // 暂停
    if ([self.tasks valueForKey:WWFileName(url)]) {
        [self handle:url];
        return;
    }
    
    // 创建缓存目录文件
    [self createCacheDirectory];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:WWFileFullpath(url) append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", WWDownloadLength(url)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    request.timeoutInterval = MAXFLOAT;
    // 创建一个Data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    
    NSUInteger taskIdentifier = arc4random() % ((arc4random() % 10000 + arc4random() % 10000));
    [task setValue:@(taskIdentifier) forKeyPath:@"taskIdentifier"];
    // 保存任务
    [self.tasks setValue:task forKey:WWFileName(url)];

    
    if ([WWSessionModel searchWithWhere:[NSString stringWithFormat:@"url = '%@'",url]].count==0) {
        WWSessionModel *sessionModel = [[WWSessionModel alloc] init];
        sessionModel.url = url;
        sessionModel.progressBlock = progressBlock;
        sessionModel.stateBlock = stateBlock;
        sessionModel.stream = stream;
        sessionModel.startTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/YYYY "];
        sessionModel.startTimeStr = [dateFormatter stringFromDate:sessionModel.startTime];
        sessionModel.fileName = WWFileName(url);
        sessionModel.imageData =  UIImagePNGRepresentation(dic[@"image"]);
        sessionModel.title = dic[@"Title"];
        
        //
        sessionModel.displayName = dic[@"displayName"];
        sessionModel.type = dic[@"type"];
        sessionModel.filePath = dic[@"filePath"];
        
        [self.sessionModels setValue:sessionModel forKey:[url lastPathComponent]];
        [self.downloadArray addObject:sessionModel];
        [self.sessionModelsArray addObject:sessionModel];
        // 保存
        [self.lkdbhelper insertToDB:sessionModel];
        
        if (self.downloadingArray.count < MaxDownloadCount) {
            [self start:url];
        }else{
            sessionModel.downloadState = DownloadStateLoading;
            sessionModel.stateBlock(DownloadStateLoading);
        }
        
    }else {
        for (WWSessionModel *sessionModel in self.sessionModelsArray) {
            if ([sessionModel.url isEqualToString:url]) {
                sessionModel.url = url;
                    
                sessionModel.progressBlock = progressBlock;
                
                sessionModel.stateBlock = stateBlock;
                sessionModel.stream = stream;
                sessionModel.startTime = [NSDate date];
                sessionModel.fileName = WWFileName(url);
                [self.sessionModels setValue:sessionModel forKey:[url lastPathComponent]];
                if (self.downloadingArray.count < MaxDownloadCount) {
                    sessionModel.downloadState = DownloadStateStart;
                    [self start:url];
                }else{
                    NSLog(@"%@",[NSThread currentThread]);
                    sessionModel.downloadState = DownloadStateLoading;
                    sessionModel.stateBlock(DownloadStateLoading);
                }
                
            }
        }
    }
    
    
    }else if ([defaults[@"onlyWifi"] isEqualToString:@"YES"]&&_xinhao==1){
        [SVProgressHUD showErrorWithStatus:@"Only use WIFI Download"];
    }
}



- (void)handle:(NSString *)url
{
    WWSessionModel *sessionModel = [self getSessionModel:url];
    if (sessionModel.downloadState == DownloadStateStart) {
        [self pause:url];
    } else if(sessionModel.downloadState == DownloadStateLoading){
        sessionModel.downloadState = DownloadStateSuspended;
        sessionModel.stateBlock(DownloadStateSuspended);
    }else{
        sessionModel.startTime = [NSDate date];
        if (self.downloadingArray.count<MaxDownloadCount) {
            [self start:url];
        }else{
            sessionModel.downloadState = DownloadStateLoading;
            sessionModel.stateBlock(DownloadStateLoading);
        }
    }
}

/**
 *  开始下载
 */
- (void)start:(NSString *)url
{
    NSURLSessionDataTask *task = [self getTask:url];
    
    WWSessionModel *sessionModel = [self getSessionModel:url];
    
    [self.downloadingArray addObject:sessionModel];
    
    [task resume];
    sessionModel.downloadState = DownloadStateStart;
    sessionModel.stateBlock(DownloadStateStart);
    if (self.downloadingArray.count>MaxDownloadCount) {
        WWSessionModel *model = [self.downloadingArray firstObject];
        [self pause:model.url];
    }
}

/**
 *  暂停下载
 */
- (void)pause:(NSString *)url
{
    
    NSURLSessionDataTask *task = [self getTask:url];
    WWSessionModel *sessionModel = [self getSessionModel:url];
    [self.downloadingArray removeObject:sessionModel];
    [task cancel];
    sessionModel.downloadState = DownloadStateSuspended;
    sessionModel.stateBlock(DownloadStateSuspended);

}

/**排序*/
-(NSArray *)sortbyTime:(NSArray *)array{
    NSArray *sorteArray1 = [array sortedArrayUsingComparator:^(WWSessionModel *obj1, WWSessionModel *obj2){
        NSDate *date1 = obj1.startTime;
        NSDate *date2 = obj2.startTime;
        if ([[date1 earlierDate:date2]isEqualToDate:date2]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([[date1 earlierDate:date2]isEqualToDate:date1]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    return sorteArray1;
}




/**
 *  根据url获得对应的下载任务
 */
- (NSURLSessionDataTask *)getTask:(NSString *)url
{
    return (NSURLSessionDataTask *)[self.tasks valueForKey:WWFileName(url)];
}

/**
 *  根据url获取对应的下载信息模型
 */
- (WWSessionModel *)getSessionModel:(NSString *)url
{
    return (WWSessionModel *)[self.sessionModels valueForKey:url.lastPathComponent];
}

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSString *)url
{

    if ([self fileTotalLength:url] && WWDownloadLength(url) == [self fileTotalLength:url]) {
        return YES;
    }
    return NO;
}


/**
 *  获取该资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)url
{
    for (WWSessionModel *model in self.sessionModelsArray) {
        if ([model.url isEqualToString:url]) {
            return model.totalLength;
        }
    }
    return 0;
}

#pragma mark - 删除
/**
 *  删除该资源
 */
- (void)deleteFile:(NSString *)url
{
    NSURLSessionDataTask *task = [self getTask:url];
    WWSessionModel *sessionModel = [self getSessionModel:url];
    if (task) {
        // 取消下载
        [task cancel];
        [self reloadDownloadingTask];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([WWSessionModel searchWithWhere:[NSString stringWithFormat:@"url = '%@'",url]].count>0) {
        // 删除沙盒中的资源
        [fileManager removeItemAtPath:WWFileFullpath(url) error:nil];
        // 删除任务
        [self.tasks removeObjectForKey:WWFileName(url)];
        [self.sessionModels removeObjectForKey:url.lastPathComponent];
        [self.sessionModelsArray removeObject:sessionModel];
        [self.downloadingArray removeObject:sessionModel];
        // 保存归档信息
             //   [self save:self.sessionModelsArray];
        [self.lkdbhelper deleteToDB:sessionModel];
    }
}

- (void)deleteFileWithUrlArray:(NSArray *)urlArray{

    for (NSString *url in urlArray) {
        NSURLSessionDataTask *task = [self getTask:url];
        WWSessionModel *sessionModel = [self getSessionModel:url];
        
        if (task) {
            // 取消下载
            [task cancel];
        }
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([WWSessionModel searchWithWhere:[NSString stringWithFormat:@"url = '%@'",url]].count>0) {
            // 删除沙盒中的资源
            [fileManager removeItemAtPath:WWFileFullpath(url) error:nil];
            // 删除任务
            [self.tasks removeObjectForKey:WWFileName(url)];
            [self.sessionModels removeObjectForKey:url.lastPathComponent];
            [self.sessionModelsArray removeObject:sessionModel];
            [self.downloadingArray removeObject:sessionModel];
            // 保存归档信息
            //        [self save:self.sessionModelsArray];
            [self.lkdbhelper deleteToDB:sessionModel];
            
        }

    }
    [self reloadDownloadingTask];

}
//标题搜索
- (NSMutableArray *)searchResouceWithTitle:(NSString *)title{


      NSMutableArray *resurtArr   = [NSMutableArray array];
    
    
    NSMutableArray *array = [self.lkdbhelper searchWithSQL:[NSString stringWithFormat:@"select * from Course where title like '%%%@%%'",title] toClass:[WWSessionModel class]];
    
    for (WWSessionModel *model in array) {
        for (WWSessionModel *sessionModel in self.sessionModelsArray) {
            if ([model.url isEqualToString:sessionModel.url]) {
                [resurtArr addObject:sessionModel];
            }
        }
    }
    return resurtArr;

}

#pragma mark NSURLSessionDataDelegate

/**
 * 接收到响应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    

    WWSessionModel *sessionModel = [self getSessionModel:dataTask.currentRequest.URL.absoluteString];
    NSLog(@"%@",dataTask.currentRequest.URL.absoluteString);
    if (!sessionModel) {
        return;
    }
    // 打开流
    [sessionModel.stream open];
    
    // 获得服务器这次请求 返回数据的总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + WWDownloadLength(sessionModel.url);
    sessionModel.totalLength = totalLength;
    // 总文件大小
    NSString *fileSizeInUnits = [NSString stringWithFormat:@"%.2f %@",
                                 [sessionModel calculateFileSizeInUnit:(unsigned long long)totalLength],
                                 [sessionModel calculateUnit:(unsigned long long)totalLength]];
    sessionModel.totalSize = fileSizeInUnits;
    // 更新数据(文件总长度)
    [WWSessionModel updateToDB:sessionModel where:nil];
    
    // 添加下载中数组
    if (![self.downloadArray containsObject:sessionModel]) {
        [self.downloadArray addObject:sessionModel];
    }
    
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    WWSessionModel *sessionModel = [self getSessionModel:dataTask.currentRequest.URL.absoluteString];
    
    // 写入数据
    [sessionModel.stream write:data.bytes maxLength:data.length];
    
    // 下载进度
    NSUInteger receivedSize = WWDownloadLength(sessionModel.url);
    sessionModel.receivedLength = receivedSize;
    sessionModel.receivedSize = [NSString stringWithFormat:@"%.2f %@",
                                 [sessionModel calculateFileSizeInUnit:(unsigned long long)receivedSize],
                                 [sessionModel calculateUnit:(unsigned long long)receivedSize]];
    NSUInteger expectedSize = sessionModel.totalLength;
    CGFloat progress = 1.0 * receivedSize / expectedSize;
    
    // 每秒下载速度
    NSTimeInterval downloadTime = -1 * [sessionModel.startTime timeIntervalSinceNow];
    NSUInteger speed = receivedSize / downloadTime;
    if (speed == 0) { return; }
    float speedSec = [sessionModel calculateFileSizeInUnit:(unsigned long long) speed];
    NSString *unit = [sessionModel calculateUnit:(unsigned long long) speed];
    NSString *speedStr = [NSString stringWithFormat:@"%.2f%@/s",speedSec,unit];
    
    // 剩余下载时间
    NSMutableString *remainingTimeStr = [[NSMutableString alloc] init];
    unsigned long long remainingContentLength = expectedSize - receivedSize;
    int remainingTime = (int)(remainingContentLength / speed);
    int hours = remainingTime / 3600;
    int minutes = (remainingTime - hours * 3600) / 60;
    int seconds = remainingTime - hours * 3600 - minutes * 60;
    
    if(hours>0) {[remainingTimeStr appendFormat:@"%d 小时 ",hours];}
    if(minutes>0) {[remainingTimeStr appendFormat:@"%d 分 ",minutes];}
    if(seconds>0) {[remainingTimeStr appendFormat:@"%d 秒",seconds];}
    
    NSString *writtenSize = [NSString stringWithFormat:@"%.2f %@",
                             [sessionModel calculateFileSizeInUnit:(unsigned long long)receivedSize],
                             [sessionModel calculateUnit:(unsigned long long)receivedSize]];
    
       dispatch_async(dispatch_get_main_queue(), ^{
           
        if (sessionModel.progressBlock) {

               sessionModel.progressBlock(progress, speedStr, remainingTimeStr,writtenSize, sessionModel.totalSize);
           }

        if ([self.delegate respondsToSelector:@selector(downloadResponse:)]) {
            [self.delegate downloadResponse:sessionModel];
        }
    });
}

/**
 * 请求完毕（成功|失败）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    

    WWSessionModel *sessionModel = [self getSessionModel:task.currentRequest.URL.absoluteString];
    [self.downloadingArray removeObject:sessionModel];
    if (!sessionModel) return;
    // 关闭流
    [sessionModel.stream close];
    sessionModel.stream = nil;
    // 清除任务
    [self.tasks removeObjectForKey:WWFileName(sessionModel.url)];
    
    [self reloadDownloadingTask];
    
    if (error) {
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (sessionModel.downloadState == DownloadStateStart) {
//                 sessionModel.downloadState = DownloadStateSuspended;
//                [self download:@{@"ResourceUrl":sessionModel.url} progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
//                    
//                } state:^(DownloadState state) {
//                    
//                }];
//            }
//            
//        });
       
    }else{
    [self.sessionModels removeObjectForKey:task.currentRequest.URL.absoluteString.lastPathComponent];
    
    [self.downloadArray removeObject:sessionModel];
    
        
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isCompletion:sessionModel.url]) {
            // 下载完成
            sessionModel.downloadState = DownloadStateCompleted;
            sessionModel.stateBlock(DownloadStateCompleted);
        } else if (error){
            // 下载失败
            sessionModel.stateBlock(DownloadStateFailed);
            sessionModel.downloadState = DownloadStateFailed;
        }
        
    });

    
    }
    
    
}

- (void)reloadDownloadingTask{
    NSArray *sortArray = [self sortbyTime:self.downloadArray];
    for (WWSessionModel *sessionModel in sortArray) {
        if (sessionModel.downloadState == DownloadStateLoading) {
            sessionModel.downloadState = DownloadStateStart;
            [self start:sessionModel.url];
            break;
        }
    }
}


#pragma mark - public
- (BOOL)isExistDownloadList:(NSString *)url{
    return  [WWSessionModel searchWithWhere:[NSString stringWithFormat:@"url = '%@'",url]].count>0;
    
}



@end
