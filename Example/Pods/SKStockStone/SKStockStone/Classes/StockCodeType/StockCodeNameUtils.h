//
//  StockCodeNameUtils.h
//  SKStockStone
//
//  Created by ryan on 02/03/2018.
//

#import <Foundation/Foundation.h>

@interface StockCodeNameUtils : NSObject

+ (NSString *)prettyCodeName:(NSUInteger)code;
+ (NSString *)plainCodeName:(NSUInteger)code;

@end
