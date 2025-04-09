#import <Foundation/Foundation.h>
#import "AppInfo.h"

@protocol ApptraceDelegate<NSObject>

@optional

/// 应用点击调起时，获取由web传递过来的动态参数（如邀请码、渠道等）和相关信息
///
/// appInfo 由web传递过来的动态参数
- (void)handleWakeUp:(nullable AppInfo *)appInfo;

@end

@interface Apptrace : NSObject

/// 获取SDK当前的版本号
+ (nonnull NSString *)sdkVersion;

/// 初始化Apptrace SDK
/// 调用该方法前，需在Info.plist文件中配置键值对
/// <key>cn.apptrace.appKey</key>
/// <string>管理平台分配的key</string>
///
/// delegate 实现ApptraceDelegate的对象实例
+ (void)initWithDelegate:(nullable id<ApptraceDelegate>)delegate;

/// 初始化Apptrace SDK
///
/// delegate 实现ApptraceDelegate的对象实例
/// appKey 管理平台分配的key
+ (void)initWithDelegate:(nullable id<ApptraceDelegate>)delegate
                  appKey:(nonnull NSString *)appKey;

/// 获取由web传递过来的动态参数（如邀请码、渠道等）和相关信息
///
/// 默认回调超时时长为: 10秒
/// success 成功回调block，在主线程回调
/// fail 失败回调block，在主线程回调
+ (void)getInstall:(void (^ _Nullable) (AppInfo * _Nullable appInfo))success
              fail:(void (^ _Nullable) (NSInteger errCode, NSString * _Nonnull errMsg))fail;

/// 获取由web传递过来的动态参数（如邀请码、渠道等）和相关信息，可自定义回调超时时长
///
/// timeout 回调超时时长，单位为秒
/// success 成功回调block，在主线程回调
/// fail 失败回调block，在主线程回调
+ (void)getInstallWithTimeout:(NSTimeInterval)timeoutSeconds
                      success:(void (^ _Nullable) (AppInfo * _Nullable appInfo))success
                         fail:(void (^ _Nullable) (NSInteger errCode, NSString * _Nonnull errMsg))fail;

/// 处理 Universal link 逻辑
///
/// userActivity 通过Universal link调起时，包含系统回调回来的URL信息的NSUserActivity
/// return bool Apptrace是否成功识别该URL
+ (BOOL)handleUniversalLink:(nullable NSUserActivity *)userActivity;

/// 设置SDK不访问剪切板，若禁用会影响匹配成功率。默认情况下，SDK会访问剪切板，以获取剪切板中的动态参数
///
/// 需要initWithDelegate之前调用才能生效
+ (void)disableClipboard;

/// 判断是否首次请求getInstall，只要请求成功过一次（success回调被调用过一次）则返回NO
///
/// return BOOL 是否首次请求
+ (BOOL)isFirstGetInstall;

/// 开启Debug模式
///
/// 仅在开发阶段开启，开启后会记录更多调试日志
/// debug 是否开启Debug模式，默认为 NO
+ (void)setDebug:(BOOL)debug;

/// 写入日志，开启Debug模式后才会生效
///
/// log 日志信息
+ (void)appendLog:(nonnull NSString *)log;

/// 提取所有的调试日志
///
/// return NSString 调试日志
+ (nullable NSString *)dumpLog;

@end


