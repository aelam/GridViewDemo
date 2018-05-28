//
//  GPBArray+NSArray.m
//  Pods
//
//  Created by ryan on 23/12/2016.
//
//

#import "GPBArray+NSArray.h"

@implementation GPBInt32Array (NSArray)

- (void)addNSArrayValues:(NSArray<NSNumber *>*)numbers {
    [self addValuesFromNSArray:numbers];
}

- (void)addValuesFromNSArray:(NSArray<NSNumber *>*)numbers {
    for (NSNumber *number in numbers) {
        [self addValue:[number intValue]];
    }
}

@end


@implementation GPBUInt32Array (NSArray)

- (void)addNSArrayValues:(NSArray<NSNumber *>*)numbers {
    [self addValuesFromNSArray:numbers];
}

- (void)addValuesFromNSArray:(NSArray<NSNumber *>*)numbers {
    for (NSNumber *number in numbers) {
        [self addValue:[number unsignedIntValue]];
    }
}

@end
