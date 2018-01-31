//
//  EncryptHelper.h
//  secret
//
//  Created by 张鹏辉 on 2017/11/8.
//  Copyright © 2017年 zph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptHelper : NSObject
/**
 加密

 @param text 文本
 @param key 密匙
 @return 加密后的文本
 */
+(NSString *)encryptHeplerEncodeWithEncryptText:(NSString *)text Key:(NSString *)key;
-(NSString *)encodeWithEncryptText:(NSString *)text Key:(NSString *)key;
/**
 解密

 @param text 文本
 @param key 密匙
 @return 解密后的文本
 */
+(NSString *)encryptHeplerDecodeWithDecryptString:(NSString *)text Key:(NSString *)key;
-(NSString *)decodeWithDecryptString:(NSString *)text Key:(NSString *)key;
@end
