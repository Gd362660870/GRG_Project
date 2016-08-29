//
//  CJJ_Data.h
//  CJJ_DearFamily
//
//  Created by 陈家劲 on 16/7/4.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJJ_Data : NSObject

/**  用户上下文对象 */
@property (nonatomic, strong) NSManagedObjectContext *familyContext;


/**
 *  单例创建coreData对象
 *
 *  @return 返回一个实例对象
 */
+(CJJ_Data *)sharedCoreData;


/**
 *  删除数据
 *
 *  @param list    表的名字
 *  @param name    表的属性
 *  @param content 表的属性内容
 *  @param context 表的上下文对象
 */
-(NSArray *)deleteList:(NSString *)list endName:(NSString *)name endContent:(NSString *)content endContext:(NSManagedObjectContext *)context;


/**
 *  更新数据
 *
 *  @param list    表的名字
 *  @param name    表的属性
 *  @param content 表的属性内容
 *  @param context 表的上下文对象
 *
 *  @return 返回一个数组
 */
/**
 *  更新数据
 *
 *  @param list      表的名字
 *  @param predicate 谓词与格式 过滤条件
 *
 *  @return 返回一个数组
 */
-(NSArray *)updateList:(NSString *)list endPredicate:(NSPredicate *)predicate;


/**
 *  查找数据
 *
 *  @param list    表的名字
 *  @param name    表的属性
 *  @param context 表的上下文对象
 *
 *  @return 返回一个数组
 */
-(NSArray *)searchList:(NSString *)list endName:(NSString *)name;
@end
