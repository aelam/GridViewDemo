//
//  StockColorFormatter.h
//  SKStockStone
//
//  Created by ryan on 08/11/2017.
//

#import <Foundation/Foundation.h>
#import "SKStockFormatter.h"

@protocol StockColorFormatter <SKStockFormatter>

- (UIColor *)objectAtIndexedSubscript:(SKStockRequireField)field;

@end

