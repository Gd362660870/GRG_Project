//
//  CJJ_Data.m
//  CJJ_DearFamily
//
//  Created by 陈家劲 on 16/7/4.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_Data.h"
#import <CoreData/CoreData.h>
@implementation CJJ_Data
+(CJJ_Data *)sharedCoreData
{
    static CJJ_Data *data = nil;
    if (data == nil) {
        data = [[super alloc]init];
        
//        data.familyContext = [data createCtx:[EMClient sharedClient].currentUsername];
        
//        NSLog(@"%@",;
        
    }

    return data;
}

/**
 *  创建一个上下文对象
 *
 *  @param name 表的名字
 *
 *  @return 返回一个上下文对象
 */
- (NSManagedObjectContext *)createCtx:(NSString *)name
{
    // 1. 上下文  使用上下文 添加数据  删除数据  查找数据  更新数据
    NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc]init];
    
    // 4. 创建管理模型
    // 添加某一个.xcdatamodeld文件到模型管理器中
    // 查找项目中所有的.xcdatamodeld 文件  添加到模型管理器中
    //    NSManagedObjectModel *modelMgr = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    
    // 一个上下文  应该对应一个数据库
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Family" withExtension:@"momd"];
    
    NSManagedObjectModel *modelMgr = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    
    // 3. 创建持久存储器对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:modelMgr];
    
    // 设置存储的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",name]];
    
    
    
    NSLog(@"path = %@",path);
    // 存储数据的类型和路径
    NSError *error = nil;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    
    if (error) {
        NSLog(@"存储器有问题");
    }
    
    // 2. 设置上下文的持久存储器
    ctx.persistentStoreCoordinator = store;
    
    return ctx;
}





// 添加数据
//- (IBAction)add:(id)sender {
//    
//    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
//    stu.name = @"xmg";
//    stu.age = [NSDate date];
//    stu.height = @(1.75);
//    
//    NSError *error = nil;
//    [self.context save:&error];
//    if (!error) {
//        NSLog(@"添加数据成功");
//    }
//}

// 删除数据
-(NSArray *)deleteList:(NSString *)list endName:(NSString *)name endContent:(NSString *)content endContext:(NSManagedObjectContext *)context{

    //获取实体名称请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:list];
    //    谓词与格式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ = %@",name,content];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error) {
        for (NSManagedObject *obj in datas) {
            [context deleteObject:obj];
            // 保存到数据库中
            [context save:nil];
        }
    }
    
    return nil;
}
/**
 *  查找数据
 *
 *  @param list    表的名字
 *  @param name    表的属性
 *
 *  @return 返回一个数组
 */
-(NSArray *)searchList:(NSString *)list endName:(NSString *)name;
 {
    // 创建一个获取数据的对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:list];
    
    // 模糊查询
    // 设置过滤条件
    // 更具开始文字查找数据
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH%@",@"gd"];
    // 根据结尾文字查找数据
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name ENDSWITH%@",@"10"];
    // 根据包含的文字的查找
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS%@",@"d14"];
    //    request.predicate = predicate;
    
    // 升序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:name ascending:YES];
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    NSArray *datas = [self.familyContext executeFetchRequest:request error:&error];
    

    if (error) {
        NSLog(@"查找数据失败%@",error);
        return  nil;
    }
     
     return datas;

}

// 更新数据
-(NSArray *)updateList:(NSString *)list endPredicate:(NSPredicate *)predicate;
{
    // 1. 查找到对应的数据进行更改
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FriendRequest"];
    

//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName = %@",@"jj8"];

    request.predicate = predicate;

    
    NSError *error = nil;
    NSArray *datas = [self.familyContext executeFetchRequest:request error:&error];
    if (!error) {
//        for (Student *stu  in datas) {
//            stu.height = @1.1;
//            // 保存到数据库中
//            [self.context save:nil];
//        }
    }

    return datas;
}
@end
