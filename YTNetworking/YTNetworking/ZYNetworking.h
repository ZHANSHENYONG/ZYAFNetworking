//
//  ZYNetworking.h
//  ZYNetworking
//


#import <Foundation/Foundation.h>

typedef void(^successBlock)(id result);
typedef void(^failureBlock)(NSError *error);


@interface ZYNetworking : NSObject


+(void)zy_GetWithURL:(NSString *)urlStr Parameter:(NSDictionary *)dic success:(successBlock)sucblock error:(failureBlock)errorBlock;

+(void)zy_POSTWithURL:(NSString *)urlStr Parameter:(NSDictionary *)dic success:(successBlock)sucblock error:(failureBlock)errorBlock;


@end
