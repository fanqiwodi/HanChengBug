//
//  DBHelper.m


#import "DBHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation DBHelper

static FMDatabaseQueue *databaseQueue = nil;

+(FMDatabase *) getDataBase:(NSString *)dbname
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:dbname];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        NSLog(@"Could not open %@",dbPath);
    }
    
    return db;
}

+(FMDatabaseQueue *) getDatabaseQueue:(NSString *)dbName;
{
  
    if (!databaseQueue) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"RongIMDemoDB%@",dbName]];
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    
    return databaseQueue;
    
}

+ (BOOL) isTableOK:(NSString *)tableName withDB:(FMDatabase *)db
{
    BOOL isOK = NO;
    
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            isOK =  NO;
        }
        else
        {
            isOK = YES;
        }
    }
    [rs close];
    
    return isOK;
}

@end
