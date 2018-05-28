//
//  GridAdapterProxy.h
//  GridView
//
//  Created by ryan on 2018/5/28.
//

#import <Foundation/Foundation.h>

@interface GridAdapterProxy : NSProxy



/**
 Create a new proxy object with targets and interceptor.
 
 @param collectionViewTarget A UICollectionViewDelegate conforming object that receives non-intercepted messages.
 @param scrollViewTarget A UIScrollViewDelegate conforming object that receives non-intercepted messages.
 @param interceptor An IGListAdapter object that intercepts a set of messages.
 
 @return A new IGListAdapterProxy object.
 */
- (instancetype)initWithCollectionViewTarget:(nullable id<UITableViewDelegate>)collectionViewTarget
                            scrollViewTarget:(nullable id<UIScrollViewDelegate>)scrollViewTarget
                                 interceptor:(UITableView *)interceptor;

/**
 :nodoc:
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 :nodoc:
 */
+ (instancetype)new NS_UNAVAILABLE;

@end
