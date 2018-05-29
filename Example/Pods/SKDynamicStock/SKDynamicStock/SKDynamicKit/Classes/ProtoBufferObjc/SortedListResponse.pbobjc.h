// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: SortedList_Response.proto

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

@class SortedList_Request;
@class SortedList_Response_ValueData;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SortedListResponseRoot

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
@interface SortedListResponseRoot : GPBRootObject
@end

#pragma mark - SortedList_Response

typedef GPB_ENUM(SortedList_Response_FieldNumber) {
  SortedList_Response_FieldNumber_RequestParams = 1,
  SortedList_Response_FieldNumber_ValueListArray = 2,
  SortedList_Response_FieldNumber_TotalSize = 3,
};

/**
 *
 * message Base_Response {
 * message Result{
 * int32 code = 1;// 0.表示成功
 * //>0.表示失败(暂不定义)
 * //<0.成功但是有警示信息需要注意(暂不定义)
 * string msg = 2;//提示信息[可选填项]
 * }
 * Result result = 1;
 * google.protobuf.Any detail = 2;//扩展detail 为下述 SortedList_Response
 * }
 **/
@interface SortedList_Response : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) SortedList_Request *requestParams;
/** Test to see if @c requestParams has been set. */
@property(nonatomic, readwrite) BOOL hasRequestParams;

/** Grid行情内容 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<SortedList_Response_ValueData*> *valueListArray;
/** The number of items in @c valueListArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger valueListArray_Count;

/** 总大小 */
@property(nonatomic, readwrite) uint32_t totalSize;

@end

#pragma mark - SortedList_Response_ValueData

typedef GPB_ENUM(SortedList_Response_ValueData_FieldNumber) {
  SortedList_Response_ValueData_FieldNumber_GoodsId = 1,
  SortedList_Response_ValueData_FieldNumber_FieldValueArray = 2,
  SortedList_Response_ValueData_FieldNumber_Exchange = 3,
  SortedList_Response_ValueData_FieldNumber_Category = 4,
  SortedList_Response_ValueData_FieldNumber_TradeSession = 5,
};

@interface SortedList_Response_ValueData : GPBMessage

/** 股票代码 */
@property(nonatomic, readwrite) uint32_t goodsId;

/** 字段对应具体行情值 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *fieldValueArray;
/** The number of items in @c fieldValueArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger fieldValueArray_Count;

/** (详见 数据使用单位转换规则说明.txt) */
@property(nonatomic, readwrite) uint32_t exchange;

/**
 * (详见 股票分类新编码规则说明.txt)
 * (详见 市场分类定义.html)
 **/
@property(nonatomic, readwrite) uint64_t category;

/**
 * (详见 股票分类新编码规则说明.txt)
 * (详见 市场分类定义.html)
 **/
@property(nonatomic, readwrite) uint32_t tradeSession;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
