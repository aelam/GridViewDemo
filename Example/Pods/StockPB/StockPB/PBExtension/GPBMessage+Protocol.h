//
//  GPBMessage+Protocol.h
//  Pods
//
//  Created by ryan on 21/12/2016.
//
//

#import <Protobuf/GPBMessage.h>

@protocol PBMessageProtocol <NSObject>

@optional
- (NSInteger)protocolId;

- (NSString *)protocolName;
@end

@interface GPBMessage (Protocol) <PBMessageProtocol>

@end
