//
//  main.m
//  secret
//
//  Created by 张鹏辉 on 2017/11/8.
//  Copyright © 2017年 zph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncryptHelper.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *encryptString = [EncryptHelper encryptHeplerEncodeWithEncryptText:@"zhang123*&^" Key:@"5dd69f95-a82a-4b01-b6c1-a2d2f8f8061b"];
        NSLog(@"%@",encryptString);
        NSString *decodeString = [EncryptHelper encryptHeplerDecodeWithDecryptString:@"GkpuKH1lqT4zC4CwR/bSKmaV/dyMwFAmECzkMOnNlP/YwM94NpfBI0RRdprYf5rHzGYQxxnIzHdk3NzZRoUCTA==" Key:@"46dbbd16abc744adb5c8f3dd5ab66e17"];
        NSLog(@"%@",decodeString);
    }
    return 0;
    
}

