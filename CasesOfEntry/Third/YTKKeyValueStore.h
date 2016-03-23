//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface YTKKeyValueStore : NSObject

- (id)initDBWithName:(NSString *)dbName;

- (id)initWithDBWithPath:(NSString *)dbPath;

- (void)createTableWithName:(NSString *)tableName;

- (BOOL)isTableExists:(NSString *)tableName;
// 清除数据表中所有数据
- (void)clearTable:(NSString *)tableName;

- (void)close;

///************************ Put&Get methods *****************************************
//写操作
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
//读操作
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
// 获得指定key的数据
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
//写操作
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;
//读操作
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
//写操作
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;
//读操作
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
// 获得所有数据
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;

- (NSUInteger)getCountFromTable:(NSString *)tableName;

// 删除指定key的数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
// 批量删除一组key数组的数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
// 批量删除所有带指定前缀的数据
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;


@end
