//
//  AFHTTPSessionManager+RAC.m
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import "SKSessionManager+RAC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SKSessionManager.h"
#import "SKServerProvider.h"

@implementation SKSessionManager (RAC)

- (RACSignal *)POSTSignalWithParameters:(id)parameters {
    return [self POSTSignalWithURL:[self.serverProvider baseURL] parameters:parameters];
}

/**
 发送https请求
 */

- (RACSignal *)POSTSignalWithURL:(NSString *)url parameters:(id)parameters {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)GETSignalWithParameters:(id)parameters {
    return [self GETSignalWithURL:[self.serverProvider baseURL] parameters:parameters];
}
    
- (RACSignal *)GETSignalWithURL:(NSString *)url parameters:(id)parameters {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)downloadSignal:(NSString *)urlString destinationPath:(NSString *)path {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLSessionDownloadTask *task = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            [subscriber sendNext: downloadProgress];
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:path];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            if (!error) {
                [subscriber sendNext:filePath];
            } else {
                [subscriber sendError:error];
            }
            [subscriber sendCompleted];
        }];
        [task resume];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


@end

@implementation SKSessionManager (RAC_DEPRECATED)
    
- (RACSignal *)requestSignalWithParameters:(id)parameters {
    return [self POSTSignalWithURL:[self.serverProvider baseURL] parameters:parameters];
}
    
- (RACSignal *)requestSignalWithURL:(NSString *)url parameters:(id)parameters {
    return [self POSTSignalWithURL:url parameters:parameters];
}

@end
