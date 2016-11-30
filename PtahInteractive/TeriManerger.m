//
//  TeriManerger.m
//  PtahInteractive
//
//  Created by ptah on 16/8/17.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "TeriManerger.h"

@implementation TeriManerger

+ (instancetype)shareManager {
    static TeriManerger *manager = nil;
    
    @synchronized(self) {
        manager = [[TeriManerger alloc] init];
    }
    
    return manager;
}

@synthesize context = _context;
@synthesize model = _model;
@synthesize coordintor = _coordintor;

-(void)saveContext{
    NSManagedObjectContext *manergercontext = self.context;
    if (manergercontext !=nil) {
        NSError *error = nil;
        if ([manergercontext hasChanges]&&![manergercontext save:&error]) {
            NSLog(@"unresolved error %@---%@",error,[error userInfo]);
            
            abort();
        }
    }
    
    
}
//懒加载


-(NSURL *)appDocumentsDirectory{
    NSString *path = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    
    return [NSURL fileURLWithPath:path];
    
}
//model的get方法 懒加载
-(NSManagedObjectModel *)model{
    if (!_model) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"PtahInteractive" ofType:@"momd"];
        
        NSURL *url = [NSURL URLWithString:path];
        
        _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
        
        
    }
    
    return _model;
    
}

//协调器 get方法  懒加载

-(NSPersistentStoreCoordinator *)coordintor{
    if (!_coordintor) {
        _coordintor = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self model]];
        
        //关联数据库
        NSString *databasepath = [NSString stringWithFormat:@"%@/MyDataBase.db",[self appDocumentsDirectory]];
        
        NSError *error = nil;
        
        [_coordintor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL URLWithString:databasepath] options:nil error:&error];
        
        
    }
    return _coordintor;
    
}

//context懒加载
-(NSManagedObjectContext *)context{
    if (!_context) {
        NSPersistentStoreCoordinator *coordinator = [self coordintor];
        
        if (!coordinator) {
            //如果协调器为空 哪么context就没有必要再创建context
            
            return nil;
        }else{
            _context = [[NSManagedObjectContext  alloc]initWithConcurrencyType:NSConfinementConcurrencyType];
            
            _context.persistentStoreCoordinator = coordinator;
            
            return _context;
            
        }
    }
    
    return _context;
}





@end
