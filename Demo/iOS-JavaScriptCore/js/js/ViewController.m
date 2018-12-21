//
//  ViewController.m
//  js
//
//  Created by Lee on 2018/12/10.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callJSFunction];
}

//objective-c
- (void)callJSFunction {
    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
    
    JSContext *ctx = [[JSContext alloc] initWithVirtualMachine:vm];
    [ctx evaluateScript:self.jsSring];
    JSValue *function = ctx[@"getOrderNo"];
    
    JSValue *resultValue = [function callWithArguments:@[[self orderString]]];
    NSString *result = [resultValue toString];
    NSLog(@"%@", result);
    
}

- (NSString *)orderString {
    return  @"{\"msg\": \"ok\",\"data\": {\"orderNo\": \"E20181210160654024100031\"},\"code\": 0}";
}

- (NSString *)jsSring {
    return @"function getOrderNo(response){\
    responseJson = JSON.parse(response);\
    return responseJson.data.orderNo;\
    }";
}

//- (void)test2
//{
//    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
//    JSContext *ctx = [[JSContext alloc] initWithVirtualMachine:vm];
//    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"js"];
//    //    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//
//    [ctx evaluateScript:[self jsString:@""]];
//
//    // 访问js对象的三种方式
//    NSLog(@"[] %@",ctx[@"a"]);
//    NSLog(@"objectForKeyedSubscript %@",[ctx objectForKeyedSubscript:@"a"]);
//    NSLog(@"globalObject %@",[ctx.globalObject objectForKeyedSubscript:@"a"]);
//
//    // 同样也可以赋值
//    ctx[@"a"] = [JSValue valueWithInt32:90 inContext:ctx];
//    [ctx setObject:[JSValue valueWithInt32:90 inContext:ctx] forKeyedSubscript:@"a"];
//    [ctx.globalObject setObject:[JSValue valueWithInt32:90 inContext:ctx] forKeyedSubscript:@"a"];
//    NSLog(@"[] %@",ctx[@"a"]);
//    NSLog(@"objectForKeyedSubscript %@",[ctx objectForKeyedSubscript:@"a"]);
//    NSLog(@"globalObject %@",[ctx.globalObject objectForKeyedSubscript:@"a"]);
//
//    // object对应NSDictionary
//    JSValue *b = ctx[@"b"];
//    NSLog(@"%@",[b toDictionary]);
//    // array对应NSArray
//    JSValue *c = ctx[@"c"];
//    NSLog(@"%@",[c toArray]);
//}
//
//- (NSString *)jsString:(NSDictionary *)jsonDict {
//    NSString *script = @"var a = 1+2+3+4+5;\
//    var b = {\
//    'red':255,\
//    'blue':0,\
//    'green':255\
//    };\
//    var c = [b];";
//    return script;
//}
@end
