//
//  AFHTTPSessionManager+RAC.h
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import <AFNetworking/AFNetworking.h>
#import <StockPB/SKSessionManager.h>

@class SKSessionManager;
@class RACSignal;

@interface SKSessionManager (RAC)

// POST
- (RACSignal *)POSTSignalWithParameters:(id)parameters;
- (RACSignal *)POSTSecureSignalWithParameters:(id)parameters;
- (RACSignal *)POSTSignalWithURL:(NSString *)url parameters:(id)parameters;// POST

// GET
- (RACSignal *)GETSignalWithParameters:(id)parameters;
- (RACSignal *)GETSignalWithURL:(NSString *)url parameters:(id)parameters;

/**
 下载文件：
 subscribeNext：取进度判断类型NSProgress，取本地路劲NSString
 subscribeError：失败
 subscribeComplete：next/error -> 完成

 @param urlString 文件全URL
 @param path 保存的本地路劲
 */
- (RACSignal *)downloadSignal:(NSString *)urlString destinationPath:(NSString *)path;
@end


@interface SKSessionManager (RAC_DEPRECATED)

// !!POST
- (RACSignal *)requestSignalWithParameters:(id)parameters;
- (RACSignal *)requestSignalWithURL:(NSString *)url parameters:(id)parameters;

@end
