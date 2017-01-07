//
//  ZYNetworking.m
//  ZYNetworking

#import "ZYNetworking.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import <CommonCrypto/CommonCrypto.h>
//#import <AFNetworking.h>


@implementation ZYNetworking

+(void)zy_GetWithURL:(NSString *)urlStr Parameter:(NSDictionary *)dic success:(successBlock)sucblock error:(failureBlock)errorBlock
{
    
    if ([self checkNetworkingStatues]) {
        
        NSString *encodString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil]];
        [manager GET:encodString parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            sucblock(responseObject);
      
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            errorBlock(error);
            
        }];
    }else
    {
        id data = [self cachePath:urlStr response:nil type:1];
        
        if (data != nil) {
            
            sucblock(data);
        }
        
    }
}



+(void)zy_POSTWithURL:(NSString *)urlStr Parameter:(NSDictionary *)dic success:(successBlock)sucblock error:(failureBlock)errorBlock
{
    
    if ([self checkNetworkingStatues]) {
        
        NSString *encodeString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil]];
        
        [manager POST:encodeString parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            sucblock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            errorBlock(error);
            
        }];
        
    }else
    {
        id data = [self cachePath:urlStr response:nil type:1];
        
        if (data != nil) {
            
            sucblock(data);
        }
    }
}

+ (id)cachePath:(NSString *)urlStr response:(id)responseObject type:(NSInteger)type
{
    NSString *fileName = [self cachedFileNameForKey:urlStr];

    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *cacheP = [cachePath stringByAppendingPathComponent:fileName];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
    
    if (0 == type) {
        [data writeToFile:cacheP atomically:YES];
        
        return nil;
    }
    else if (1 == type) {
        id data = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheP];
        
        return data;
    }
    NSLog(@"%@", cacheP);
    
    return nil;
    
}

+ (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}

+(BOOL)checkNetworkingStatues
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    if (reachability.currentReachabilityStatus == NotReachable) {
        
        return NO;
        
    }else
    {
        return YES;
    }
}

@end




















