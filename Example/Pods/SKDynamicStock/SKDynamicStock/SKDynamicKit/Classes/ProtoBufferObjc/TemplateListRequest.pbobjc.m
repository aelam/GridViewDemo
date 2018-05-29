// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: TemplateList_Request.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "TemplateListRequest.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - TemplateListRequestRoot

@implementation TemplateListRequestRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - TemplateListRequestRoot_FileDescriptor

static GPBFileDescriptor *TemplateListRequestRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@""
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - TemplateList_Request

@implementation TemplateList_Request

@dynamic templateName;

typedef struct TemplateList_Request__storage_ {
  uint32_t _has_storage_[1];
  NSString *templateName;
} TemplateList_Request__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "templateName",
        .dataTypeSpecific.className = NULL,
        .number = TemplateList_Request_FieldNumber_TemplateName,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TemplateList_Request__storage_, templateName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TemplateList_Request class]
                                     rootClass:[TemplateListRequestRoot class]
                                          file:TemplateListRequestRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TemplateList_Request__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)