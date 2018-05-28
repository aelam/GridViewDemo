//
//  GPBArray+NSArray.h
//  Pods
//
//  Created by ryan on 23/12/2016.
//
//

#import <Protobuf/GPBArray.h>

@interface GPBInt32Array (NSArray)

- (void)addNSArrayValues:(NSArray <NSNumber *>*)values __deprecated;
- (void)addValuesFromNSArray:(NSArray<NSNumber *>*)numbers;

@end

@interface GPBUInt32Array (NSArray)

- (void)addNSArrayValues:(NSArray <NSNumber *>*)values __deprecated;
- (void)addValuesFromNSArray:(NSArray<NSNumber *>*)numbers;

@end
