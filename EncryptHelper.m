//
//  EncryptHelper.m
//  secret
//
//  Created by 张鹏辉 on 2017/11/8.
//  Copyright © 2017年 zph. All rights reserved.
//

#import "EncryptHelper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation EncryptHelper

NSData* hexToBytes(NSString *hex) {
    NSMutableData* data = [NSMutableData data];
    unsigned int idx, intValue;
    for (idx = 0; idx+2 <= hex.length; idx+=2) {
        NSString* hexStr = [hex substringWithRange:NSMakeRange(idx, 2)];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

//md5
- (NSString *)md5StringWithString:(NSString *)string {
    const char *str = string.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}

+(NSString *)encryptHeplerEncodeWithEncryptText:(NSString *)text Key:(NSString *)key {
    
    return [[self alloc]encodeWithEncryptText:text Key:key];
}

-(NSString *)encodeWithEncryptText:(NSString *)text Key:(NSString *)key {
    
    NSString *hex = @"0123456789ABCDEF";
    NSData *datahex = [hex dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytehex = (Byte *)[datahex bytes];
    
    NSString *md5key = [self md5StringWithString:key];
    NSData *datakey = hexToBytes(md5key);
    Byte *bytekey = (Byte *)[datakey bytes];
    
    NSData *content = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t bufferSize = content.length + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus result;
    result = CCCrypt(kCCEncrypt, kCCAlgorithmAES,
                     kCCOptionPKCS7Padding,
                     bytekey, datakey.length,
                     bytehex,
                     content.bytes, content.length,
                     buffer, bufferSize, &numBytesEncrypted);
    
    if(result == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *string = [data base64EncodedStringWithOptions:0];
        return string;
    }
    return nil;
}

+(NSString *)encryptHeplerDecodeWithDecryptString:(NSString *)text Key:(NSString *)key {
    
    return [[self alloc]decodeWithDecryptString:text Key:key];
}

-(NSString *)decodeWithDecryptString:(NSString *)text Key:(NSString *)key {
    
    NSString *hex = @"0123456789ABCDEF";
    NSData *datahex = [hex dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytehex = (Byte *)[datahex bytes];
    
    NSString *md5key = [self md5StringWithString:key];
    NSData *datakey = hexToBytes(md5key);
    Byte *bytekey = (Byte *)[datakey bytes];
    
    NSData *content = [[NSData alloc]initWithBase64EncodedString:text options:0];
    
    size_t bufferSize = content.length + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus result;
    result = CCCrypt(kCCDecrypt, kCCAlgorithmAES,
                     kCCOptionPKCS7Padding,
                     bytekey, datakey.length,
                     bytehex,
                     content.bytes, content.length,
                     buffer, bufferSize, &numBytesEncrypted);
    
    if(result == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
    return nil;
}

@end
