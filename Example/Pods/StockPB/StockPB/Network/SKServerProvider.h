//
//  SKServerSelectProtocol.h
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import <Foundation/Foundation.h>

@protocol SKServerProvider <NSObject>

@property (nonatomic, readonly) NSString *baseURL;
@end
