// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: TimeStatus_Response.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class TimeStatus_Request;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - TimeStatusResponseRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface TimeStatusResponseRoot : GPBRootObject
@end

#pragma mark - TimeStatus_Response

typedef GPB_ENUM(TimeStatus_Response_FieldNumber) {
  TimeStatus_Response_FieldNumber_RequestParams = 1,
  TimeStatus_Response_FieldNumber_TradeStatus = 2,
  TimeStatus_Response_FieldNumber_MarketDate = 3,
  TimeStatus_Response_FieldNumber_MarketTime = 4,
  TimeStatus_Response_FieldNumber_SystemTimestamp = 5,
};

/**
 * X-Protocol-Id=3300
 **/
@interface TimeStatus_Response : GPBMessage

/** 请求参数 */
@property(nonatomic, readwrite, strong, null_resettable) TimeStatus_Request *requestParams;
/** Test to see if @c requestParams has been set. */
@property(nonatomic, readwrite) BOOL hasRequestParams;

/** 交易状态（0.无状态【不显示】1.未开盘 2.交易中 3.已收盘 4.非交易日） */
@property(nonatomic, readwrite) uint32_t tradeStatus;

/** 所属交易所当地日期YYYYMMDD */
@property(nonatomic, readwrite) uint32_t marketDate;

/** 所属交易所当地时间hhmmss */
@property(nonatomic, readwrite) uint32_t marketTime;

/** 服务器系统unix时间戳 */
@property(nonatomic, readwrite) uint64_t systemTimestamp;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
