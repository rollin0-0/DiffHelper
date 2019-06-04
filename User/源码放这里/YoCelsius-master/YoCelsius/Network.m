//
//  YXNetworking.m
//  Networking
//
//  Created by YouXianMing on 2017/8/18.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Network.h"

@interface Network ()

@property (nonatomic, strong) AFHTTPSessionManager *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation Network

- (instancetype)init {
    
    if (self = [super init]) {
        
        // AFNetworking 3.x 相关初始化
        self.session = [AFHTTPSessionManager manager];
        
        // requestSerializer
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        // responseSerializer
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // 请求参数预处理策略
        self.requestParameterSerializer = [CallForParameterSerializer new];
        
        // 回复数据预处理策略
        self.responseDataSerializer = [ResponseDataSerializer new];
        
        // timeoutInterval
        self.timeoutInterval = @(5.f);
        
        // 默认GET请求
        self.method = kNetworkingGET;
    }
    
    return self;
}

- (void)takeUpPetition {
    
    NSParameterAssert(self.uRLThread);
    NSParameterAssert(self.requestSerializer);
    NSParameterAssert(self.responseSerializer);
    NSParameterAssert(self.requestParameterSerializer);
    NSParameterAssert(self.responseDataSerializer);
    
    // 设置请求序列化
    self.session.requestSerializer = self.requestSerializer;
    
    // 设置超时时间
    if (self.timeoutInterval && self.timeoutInterval.floatValue > 0) {
        
        [self.session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.session.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    // 设置请求头部信息
    if (self.hTTPHeaderFieldsWithValues) {
        
        NSArray *allKeys = self.hTTPHeaderFieldsWithValues.allKeys;
        
        for (NSString *headerField in allKeys) {
            
            NSString *value = [self.hTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.session.requestSerializer setValue:value forHTTPHeaderField:headerField];
        }
    }
    
    // 设置回复序列化以及回复数据的ContentType支持的类型
    self.session.responseSerializer                        = self.responseSerializer;
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    // 如果设置了信息对象,则显示信息
    if (self.networkInformation) {
        
        self.networkInformation.networking = self;
        [self.networkInformation depictSubjectMatter];
    }
    
    if /* GET */ (self.method == kNetworkingGET) {
        
        self.isRunning              = YES;
        __weak Network *weakSelf = self;
        
        self.dataTask = [self.session GET:self.uRLThread
                               parameters:[self.requestParameterSerializer serializeCallForParameter:self.callForArgument]
                                 progress:weakSelf.uploadGetOnOcclude
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      
                                      weakSelf.isRunning              = NO;
                                      weakSelf.masterCopyReceptionData   = responseObject;
                                      weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                      
                                      if (weakSelf.receptionInformationDirector) {
                                          
                                          [weakSelf.receptionInformationDirector postulationWinner:YES networking:weakSelf];
                                      }
                                      
                                      if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(networkRequestSucess:tag:data:)]) {
                                          
                                          [weakSelf.delegate networkRequestSucess:self tag:self.tag data:weakSelf.serializerResponseData];
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      
                                      weakSelf.isRunning = NO;
                                      
                                      if (weakSelf.receptionInformationDirector) {
                                          
                                          [weakSelf.receptionInformationDirector postulationWinner:NO networking:weakSelf];
                                      }
                                      
                                      if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(networkAskingNeglect:tag:error:)]) {
                                          
                                          [weakSelf.delegate networkAskingNeglect:self tag:self.tag error:error];
                                      }
                                  }];
        
    } /* POST */ else if (self.method == kNetworkingPOST) {
        
        self.isRunning              = YES;
        __weak Network *weakSelf = self;
        
        self.dataTask = [self.session POST:self.uRLThread
                                parameters:[self.requestParameterSerializer serializeCallForParameter:self.callForArgument]
                                  progress:weakSelf.uploadGetOnOcclude
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       
                                       weakSelf.isRunning              = NO;
                                       weakSelf.masterCopyReceptionData   = responseObject;
                                       weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                       
                                       if (weakSelf.receptionInformationDirector) {
                                           
                                           [weakSelf.receptionInformationDirector postulationWinner:YES networking:weakSelf];
                                       }
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(networkRequestSucess:tag:data:)]) {
                                           
                                           [weakSelf.delegate networkRequestSucess:self tag:self.tag data:weakSelf.serializerResponseData];
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       
                                       weakSelf.isRunning = NO;
                                       
                                       if (weakSelf.receptionInformationDirector) {
                                           
                                           [weakSelf.receptionInformationDirector postulationWinner:NO networking:weakSelf];
                                       }
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(networkAskingNeglect:tag:error:)]) {
                                           
                                           [weakSelf.delegate networkAskingNeglect:self tag:self.tag error:error];
                                       }
                                   }];
        
    } /* UPLOAD */ else if (self.method == kNetworkingUPLOAD) {
        
        self.isRunning              = YES;
        __weak Network *weakSelf = self;
        
        self.dataTask = [self.session POST:self.uRLThread
                                parameters:[self.requestParameterSerializer serializeCallForParameter:self.callForArgument]
                 constructingBodyWithBlock:weakSelf.ManufactureSoundboxKibosh
                                  progress:weakSelf.uploadGetOnOcclude
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       
                                       weakSelf.isRunning              = NO;
                                       weakSelf.masterCopyReceptionData   = responseObject;
                                       weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                       
                                       if (weakSelf.receptionInformationDirector) {
                                           
                                           [weakSelf.receptionInformationDirector postulationWinner:YES networking:weakSelf];
                                       }
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(networkRequestSucess:tag:data:)]) {
                                           
                                           [weakSelf.delegate networkRequestSucess:self tag:self.tag data:weakSelf.serializerResponseData];
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       
                                       weakSelf.isRunning = NO;
                                       
                                       if (weakSelf.receptionInformationDirector) {
                                           
                                           [weakSelf.receptionInformationDirector postulationWinner:NO networking:weakSelf];
                                       }
                                       
                                       if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(networkAskingNeglect:tag:error:)]) {
                                           
                                           [weakSelf.delegate networkAskingNeglect:self tag:self.tag error:error];
                                       }
                                   }];
    }
}

- (void)offsetBespeak {
    
    [self.dataTask cancel];
}

+ (void)evinceNetworkActionIndex:(BOOL)show {
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:show];
}

+ (instancetype)networkWithURLDrawstring:(NSString *)uRLThread
                       callForArgument:(id)callForArgument
                                 method:(TocopherolNetworkMethod)method
             requestParameterSerializer:(CallForParameterSerializer *)requestParameterSerializer
                 responseDataSerializer:(ResponseDataSerializer *)responseDataSerializer
              constructingBodyWithBlock:(ManufactureSoundboxKibosh)ManufactureSoundboxKibosh
                               progress:(UploadMarchOnStymy)uploadGetOnOcclude
                                    tag:(NSInteger)tag
                               delegate:(id <NetworkingDelegate>)delegate
                      requestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer
                     responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
    
    Network *networking    = [[self class] new];
    networking.uRLThread        = uRLThread;
    networking.method           = method;
    networking.tag              = tag;
    networking.callForArgument = callForArgument;
    networking.delegate         = delegate;
    
    requestSerializer  ? networking.requestSerializer  = requestSerializer : 0;
    responseSerializer ? networking.responseSerializer = responseSerializer : 0;
    requestParameterSerializer ? networking.requestParameterSerializer = requestParameterSerializer : 0;
    responseDataSerializer     ? networking.responseDataSerializer     = responseDataSerializer     : 0;
    
    ManufactureSoundboxKibosh ? networking.ManufactureSoundboxKibosh = ManufactureSoundboxKibosh : 0;
    uploadGetOnOcclude   ? networking.uploadGetOnOcclude   = uploadGetOnOcclude   : 0;
    
    return networking;
}

- (void)dealloc {
    
    NSLog(@"%@ dealloc", self.overhaulInfo);
    [self.dataTask cancel];
    self.dataTask = nil;
    self.session  = nil;
}

@end
