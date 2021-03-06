//
//  HttpToolMappingModel.m
//  ZJZCProject
//
//  Created by 世缘 on 16/6/14.
//  Copyright © 2016年 BoShang. All rights reserved.
//

#import "AAHttpToolMappingModel.h"
#import "NSDictionary+AACategory.h"
#import "NSString+AAPassword.h"
#import "MJExtension.h"

@implementation AAHttpToolMappingModel
MJCodingImplementation

+ (instancetype)initModelWithCode:(HttpCodeType)code{
    AAHttpToolMappingModel *model = [[self alloc] init];
    model.code = code;
    model.errorMessage = @"";
    return model;
}

+ (instancetype)initModelWithError:(NSError *)error code:(HttpCodeType)code{
    AAHttpToolMappingModel *model = [[self alloc] init];
    model.code = code;
    model.error = error;
    return model;
}

+ (instancetype)initModelWithError:(NSError *)error code:(HttpCodeType)code mappingModel:(id)mappingModel{
    AAHttpToolMappingModel *model = [[self alloc] init];
    model.error = error;
    model.code = code;
    model.mappingModel = mappingModel;
    return model;
}

+ (instancetype)initModelWithError:(NSError *)error code:(HttpCodeType)code msg:(NSString *)errorMesssage{
    AAHttpToolMappingModel *model = [[self alloc] init];
    model.error = error;
    model.code = code;
    model.errorMessage = errorMesssage;
    return model;
}

+ (instancetype)initModelWithMappingModel:(id)mappingModel{
    AAHttpToolMappingModel *model = [[self alloc] init];
    model.mappingModel = mappingModel;
    return model;
}

- (instancetype)initMappingModelWithResponseObject:(id)responseObject mappingModel:(Class)mappingModel{
    if (self = [super init]) {
        self.code = HttpCodeTypeSuccess;
        
        
        NSObject *resultMapping = [[NSObject alloc] init];
        NSString *resultText = responseObject;
        if (responseObject != nil && responseObject != [NSNull null] && mappingModel != nil) {
            
            NSDictionary *resultDic = responseObject;
           
            [self tokenInvali:resultDic];
            if ([resultDic isKindOfClass:[NSDictionary class]]) {
                if ([mappingModel respondsToSelector:@selector(mj_objectWithKeyValues:)]) {
                    resultMapping = [mappingModel performSelector:@selector(mj_objectWithKeyValues:) withObject:resultDic];
                    self.mappingFlag = YES;
                }
            }
            
        }else{
            
            NSDictionary *resultDic = [NSDictionary aa_dictionaryWithJsonString:resultText];
            resultMapping = resultDic;
            self.mappingFlag = NO;
        }
        self.mappingModel = resultMapping;
    }
    return self;
}

- (void)tokenInvali:(NSDictionary *)dic{
    NSString *errorCode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"errcode"]];
   
}

#pragma mark 解密
- (NSString *)httpResponseDataDecryption:(NSData *)data{
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    self.responseData = result;
    
//    NSString *json = [NSString aa_textFromBase64String:result];
    return result;
}

@end
