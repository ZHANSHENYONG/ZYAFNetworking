//
//  ViewController.m
//  YTNetworking
//
//  Created by yutao on 16/5/15.
//  Copyright © 2016年 yutao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [ZYNetworking zy_GetWithURL:@"http://c.3g.163.com/nc/article/list/T1348649580692/0-20.html" Parameter:nil success:^(id result) {

        NSLog(@"get===%@",result);

    } error:^(NSError *error) {



    }];





//    NSString *bodyStr = @"cacheKey=Recipe.getFindRecipe&sign=&uid=&uuid=02288be08f4b871a69565746255b0de9";

    NSDictionary *dic = @{@"cacheKey":@"Recipe.getFindRecipe",@"uuid":@"02288be08f4b871a69565746255b0de9"};

    [ZYNetworking zy_POSTWithURL:@"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=cee6710ae48a3945b398702d8702510a&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C552EE383-0FAD-4555-9979-AC38A01C5D6D%7C9C579DCC-7C8F-4E53-AEB6-54527C473309&format=json&loguid=&method=Recipe.getFindRecipe&nonce=1443856978&sessionid=1443856790&signmethod=md5&timestamp=1443856978&uuid=02288be08f4b871a69565746255b0de9&v=2&vc=40&vn=v5.1.0" Parameter:dic success:^(id result) {

        NSLog(@"POST===%@",result);


    } error:^(NSError *error) {


    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
