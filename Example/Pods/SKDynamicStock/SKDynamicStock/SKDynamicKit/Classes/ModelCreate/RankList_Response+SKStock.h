//
//  RankList_Response+SKStock.h
//  Pods
//
//  Created by ryan on 05/01/2017.
//
//

#import "RankListResponse.pbobjc.h"

@import SKStockStone;

@protocol PBResponseModelCreation;
@protocol SKStock;

@interface RankList_Response (SKStock) <PBResponseModelCreation>

@end
