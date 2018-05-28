//
//  SKSessionManager+WebStatic.m
//  StockPB
//
//  Created by RenChao on 2018/1/22.
//

#import "SKSessionManager+WebStatic.h"
#import "SKServerProvider.h"

#import <objc/runtime.h>

static char SKThemeNameKey;

@interface SKSessionManager()

@property (strong, nonatomic) NSString *themeName;

@end

@implementation SKSessionManager (WebStatic)

static SKSessionManager *sharedWebStaticManager = nil;

+ (void)setSharedWebStaticManager:(SKSessionManager *)manager {
    sharedWebStaticManager = manager;
}

+ (instancetype)sharedWebStaticManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWebStaticManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self webStaticSessionConfiguration]];
    });

    return sharedWebStaticManager;
}

+ (NSURLSessionConfiguration *)webStaticSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 15;
    if (@available(iOS 11.0, *)) {
//        configuration.waitsForConnectivity = YES;
    } else {
    }

    return configuration;
}

- (void)updateThemeName:(NSString *)name
{
    self.themeName = name;
}

- (NSString *)getAbsoluteThemeURL:(NSString *)path
{
    NSString *theme = @"?";
    if ([self.themeName isEqualToString:@"black"] ) {
        theme = @"?css=night&";
    }

    return [NSString stringWithFormat:@"%@%@%@", self.serverProvider.baseURL, path, theme];
}

- (NSString *)getAbsoluteURL:(NSString *)path
{
    return [NSString stringWithFormat:@"%@%@", self.serverProvider.baseURL, path];
}

// MARK: - runtime

- (NSString *)themeName
{
return objc_getAssociatedObject(self, &SKThemeNameKey);
}

- (void)setThemeName:(NSString *)themeName
{
    objc_setAssociatedObject(self, &SKThemeNameKey, themeName, OBJC_ASSOCIATION_RETAIN);
}

@end
