//
//  DBHelper.h


#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface DBHelper : NSObject


+(FMDatabase *) getDataBase:(NSString *)dbname;

+(BOOL) isTableOK:(NSString *)tableName withDB:(FMDatabase *)db;


+(FMDatabaseQueue *) getDatabaseQueue:(NSString *)dbName;
@end

