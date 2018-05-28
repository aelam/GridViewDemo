//
//  SKRequestMiddleWare.h
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import <Foundation/Foundation.h>

@protocol SKRequestMiddleWare <NSObject>

@optional
- (void)requestDidSuccess:(NSURLSessionDataTask *)task responseObject:(id)responseObject;
- (void)requestDidFail:(NSURLSessionDataTask *)task error:(NSError *)error;

@end
