//
//  GridAdapterProxy.m
//  GridView
//
//  Created by ryan on 2018/5/28.
//

#import "GridAdapterProxy.h"

static BOOL isInterceptedSelector(SEL sel) {
    return (
            // UICollectionViewDelegate
            sel == @selector(tableView:didSelectRowAtIndexPath:) ||
            sel == @selector(tableView:willDisplayCell:forRowAtIndexPath:) ||
//            sel == @selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:) ||
            // UIScrollViewDelegate
            sel == @selector(scrollViewDidScroll:) ||
            sel == @selector(scrollViewWillBeginDragging:) ||
            sel == @selector(scrollViewDidEndDragging:willDecelerate:) ||
            sel == @selector(scrollViewDidEndDecelerating:)
            );
}


@implementation GridAdapterProxy {
    __weak id _collectionViewTarget;
    __weak id _scrollViewTarget;
    __weak id _interceptor;

}

- (instancetype)initWithCollectionViewTarget:(nullable id<UITableViewDelegate>)collectionViewTarget
                            scrollViewTarget:(nullable id<UIScrollViewDelegate>)scrollViewTarget
                                 interceptor:(UITableView *)interceptor {
    NSAssert(interceptor != nil, @"interceptor != nil !!");
    // -[NSProxy init] is undefined
    if (self) {
        _collectionViewTarget = collectionViewTarget;
        _scrollViewTarget = scrollViewTarget;
        _interceptor = interceptor;
    }
    return self;
}


- (BOOL)respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector)
    || [_collectionViewTarget respondsToSelector:aSelector]
    || [_scrollViewTarget respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (isInterceptedSelector(aSelector)) {
        return _interceptor;
    }
    
    // since UICollectionViewDelegate is a superset of UIScrollViewDelegate, first check if the method exists in
    // _scrollViewTarget, otherwise use the _collectionViewTarget
    return [_scrollViewTarget respondsToSelector:aSelector] ? _scrollViewTarget : _collectionViewTarget;
}

// handling unimplemented methods and nil target/interceptor
// https://github.com/Flipboard/FLAnimatedImage/blob/76a31aefc645cc09463a62d42c02954a30434d7d/FLAnimatedImage/FLAnimatedImage.m#L786-L807
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}


@end
