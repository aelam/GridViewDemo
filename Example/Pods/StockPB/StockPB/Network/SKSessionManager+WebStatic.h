//
//  SKSessionManager+WebStatic.h
//  StockPB
//
//  Created by RenChao on 2018/1/22.
//

#import <StockPB/SKSessionManager.h>

@interface SKSessionManager (WebStatic)

+ (void)setSharedWebStaticManager:(SKSessionManager *)manager;
+ (instancetype)sharedWebStaticManager;

// 切换主题，更新主题name
- (void)updateThemeName:(NSString *)name;

/**
 desp:
    生成包含主题的Url，只作用于静态web页，一般用于半屏webview
 path:
    eg./emapphtml/doc/warning
 return:
    黑板：http://192.168.1.1/emapphtml/doc/warning?css=night&
    白板：http://192.168.1.1/emapphtml/doc/warning?
 */
- (NSString *)getAbsoluteThemeURL:(NSString *)path;

/**
 desp:
    生成不包含主题的Url，只作用于静态web页，一般用于全半屏webview
 path:
    eg./emapphtml/doc/warning
 return:
    http://192.168.1.1/emapphtml/doc/warning
 */
- (NSString *)getAbsoluteURL:(NSString *)path;

@end
