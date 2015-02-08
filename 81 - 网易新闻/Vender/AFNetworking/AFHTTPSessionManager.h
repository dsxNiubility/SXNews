// AFHTTPSessionManager.h
//
// Copyright (c) 2013-2015 AFNetworking (http://afnetworking.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "AFURLSessionManager.h"

/**
 `AFHTTPSessionManager` is a subclass of `AFURLSessionManager` with convenience methods for making HTTP requests. When a `baseURL` is provided, requests made with the `GET` / `POST` / et al. convenience methods can be made with relative paths.
 <ul>
 <li>`AFHTTPSessionManager` 是 `AFURLSessionManager` 的子类，提供 HTTP 请求的常用方法</li>
 <li>如果指定了 `baseURL`，则 `GET` / `POST` 等方法可以使用相对路径</li>
 </ul>

 ## Subclassing Notes - 子类注意事项

 Developers targeting iOS 7 or Mac OS X 10.9 or later that deal extensively with a web service are encouraged to subclass `AFHTTPSessionManager`, providing a class method that returns a shared singleton object on which authentication and other configuration can be shared across the application.
 <ul>
 <li>要开发 iOS 7 或 Mac OS X 10.9 以上版本的 web 交互应用，建议使用 `AFHTTPSessionManager` 子类</li>
 <li>提供一个类方法返回全局共享的单例对象，这样诸如身份验证等其他配置便可以在整个应用程序中共享</li>
 </ul>

 For developers targeting iOS 6 or Mac OS X 10.8 or earlier, `AFHTTPRequestOperationManager` may be used to similar effect.
 <br />要开发支持 iOS 6 或 Mac OS X 10.8 之前版本，使用 `AFHTTPRequestOperationManager` 能够达到类似的效果

 ## Methods to Override - 重写的方法

 To change the behavior of all data task operation construction, which is also used in the `GET` / `POST` / et al. convenience methods, override `dataTaskWithRequest:completionHandler:`.
 <br />如果要修改所有数据任务操作的行为，包括 `GET` / `POST` 等常用方法，可以重写 `dataTaskWithRequest:completionHandler:` 方法

 ## Serialization - 序列化/反序列化

 Requests created by an HTTP client will contain default headers and encode parameters according to the `requestSerializer` property, which is an object conforming to `<AFURLRequestSerialization>`.
 <ul>
 <li>HTTP 客户端创建的请求包含默认请求头和根据 `requestSerializer` 属性编码的参数</li>
 <li>该属性是一个遵守 `AFURLRequestSerialization` 协议的对象</li>
 </ul>
 
 Responses received from the server are automatically validated and serialized by the `responseSerializers` property, which is an object conforming to `<AFURLResponseSerialization>`
 
 <ul>
 <li>从服务器接收到的响应将被自动验证，并由 `responseSerializers` 属性反序列化</li>
 <li>该属性是一个遵守 `AFURLResponseSerialization` 协议的对象</li>
 </ul>

 ## URL Construction Using Relative Paths － 使用相对路径构造 URL

 For HTTP convenience methods, the request serializer constructs URLs from the path relative to the `-baseURL`, using `NSURL +URLWithString:relativeToURL:`, when provided. If `baseURL` is `nil`, `path` needs to resolve to a valid `NSURL` object using `NSURL +URLWithString:`.
 <p>对于 HTTP 常用方法</p>
 <ul>
 <li>如果提供了 `-baseURL`，请求序列化构造器使用 `NSURL +URLWithString:relativeToURL:` 方法，以 `-baseURL` 作为参照路径构建 URL</li>
 <li>如果 `baseURL` 是 `nil`，则使用 `NSURL +URLWithString:` 方法将 `path` 解析为合法的 `NSURL` 对象</li>
 </ul>

 Below are a few examples of how `baseURL` and relative paths interact:
 <p>以下是 `baseURL` 和相对路径的几个示例：</p>

    NSURL *baseURL = [NSURL URLWithString:@"http://example.com/v1/"];
    [NSURL URLWithString:@"foo" relativeToURL:baseURL];                  // http://example.com/v1/foo
    [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];          // http://example.com/v1/foo?bar=baz
    [NSURL URLWithString:@"/foo" relativeToURL:baseURL];                 // http://example.com/foo
    [NSURL URLWithString:@"foo/" relativeToURL:baseURL];                 // http://example.com/v1/foo
    [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];                // http://example.com/foo/
    [NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL]; // http://example2.com/
 
 <ul>
    <li>NSURL *baseURL = [NSURL URLWithString:@"<font color="green">http://example.com/v1/</font>"];</li>
    <li>[NSURL URLWithString:@"foo" relativeToURL:baseURL];                  // <font color="green">http://example.com/v1/foo</font></li>
    <li>[NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];          // <font color="green">http://example.com/v1/foo?bar=baz</font></li>
    <li>[NSURL URLWithString:@"/foo" relativeToURL:baseURL];                 // <font color="green">http://example.com/foo</font></li>
    <li>[NSURL URLWithString:@"foo/" relativeToURL:baseURL];                 // <font color="green">http://example.com/v1/foo</font></li>
    <li>[NSURL URLWithString:@"/foo/" relativeToURL:baseURL];                // <font color="green">http://example.com/foo/</font></li>
    <li>[NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL]; // <font color="green">http://example2.com/</font></li>
 </ul>

 Also important to note is that a trailing slash will be added to any `baseURL` without one. This would otherwise cause unexpected behavior when constructing URLs using paths without a leading slash.
 <p><strong>注意：</strong>`baseURL` 的末尾必须包含一个斜线，否则在使用没有前导斜线的路径构造 URL 时会出现问题！</p>

 @warning Managers for background sessions must be owned for the duration of their use. This can be accomplished by creating an application-wide or shared singleton instance.
 <br />后台会话的管理器必须被长期持有，以保证有足够的时间完成工作，可以创建一个应用程序范围的管理器或者共享的单例来实现。
 */

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)

@interface AFHTTPSessionManager : AFURLSessionManager <NSSecureCoding, NSCopying>

/**
 The URL used to monitor reachability, and construct requests from relative paths in methods like `requestWithMethod:URLString:parameters:`, and the `GET` / `POST` / et al. convenience methods.
 <ul>
 <li>检测网络连接状态的 URL</li>
 <li>在 `requestWithMethod:URLString:parameters:` 及 `GET` / `POST` 等常用方法中相对路径的参照路径</li>
 </ul>
 */
@property (readonly, nonatomic, strong) NSURL *baseURL;

/**
 Requests created with `requestWithMethod:URLString:parameters:` & `multipartFormRequestWithMethod:URLString:parameters:constructingBodyWithBlock:` are constructed with a set of default headers using a parameter serialization specified by this property. By default, this is set to an instance of `AFHTTPRequestSerializer`, which serializes query string parameters for `GET`, `HEAD`, and `DELETE` requests, or otherwise URL-form-encodes HTTP message bodies.
 <ul>
 <li>使用 `requestWithMethod:URLString:parameters:` 或 `multipartFormRequestWithMethod:URLString:parameters:constructingBodyWithBlock:` 方法创建的请求</li>
 <li>使用本属性指定的参数序列化创建请求头</li>
 <li>默认情况下，是 `AFHTTPRequestSerializer` 的实例，为 `GET`、`HEAD` 和 `DELETE` 等请求序列化查询字符串参数</li>
 <li>也可以是 URL-form-encodes 的 HTTP 数据体</li>
 </ul>

 @warning `requestSerializer` must not be `nil`.
  <br />`requestSerializer` 不能为nil
 */
@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer;

/**
 Responses sent from the server in data tasks created with `dataTaskWithRequest:success:failure:` and run using the `GET` / `POST` / et al. convenience methods are automatically validated and serialized by the response serializer. By default, this property is set to an instance of `AFJSONResponseSerializer`.
 <ul>
 <li>使用 `GET` / `POST` 等常用方法通过 `dataTaskWithRequest:success:failure:` 数据任务创建的由服务器返回的响应</li>
 <li>响应数据会被自动验证并由响应序列化器反序列化</li>
 <li>默认情况下，该属性是 `AFJSONResponseSerializer` 的实例(默认服务器返回的是 JSON 数据)</li>
 </ul>

 @warning `responseSerializer` must not be `nil`.
 <br />`responseSerializer` 不能为nil
 */
@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * responseSerializer;

///---------------------
/// @name Initialization
///---------------------

/**
 Creates and returns an `AFHTTPSessionManager` object.
 <br />创建并返回一个 `AFHTTPSessionManager` 对象
 */
+ (instancetype)manager;

/**
 Initializes an `AFHTTPSessionManager` object with the specified base URL.
 <br />使用指定的 `baseURL` 初始化一个 `AFHTTPSessionManager` 对象

 @param url The base URL for the HTTP client.
            <br />HTTP 客户端的基础 URL

 @return The newly-initialized HTTP client
            <br />新初始化的 HTTP 客户端
 */
- (instancetype)initWithBaseURL:(NSURL *)url;

/**
 Initializes an `AFHTTPSessionManager` object with the specified base URL.
 <br />使用指定的 `baseURL` 初始化一个 `AFHTTPSessionManager` 对象

 This is the designated initializer.
 <br />这是指定的初始化方法

 @param url The base URL for the HTTP client.
            <br />HTTP 客户端的基础 URL
 @param configuration The configuration used to create the managed session.
            <br />用于创建管理的网络会话的配置

 @return The newly-initialized HTTP client
            <br />新初始化的 HTTP 客户端
 */
- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

///---------------------------
/// @name Making HTTP Requests
///---------------------------

/**
 Creates and runs an `NSURLSessionDataTask` with a `GET` request.
 <br />使用 `GET` 请求创建并运行一个 `NSURLSessionDataTask`

 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和由客户端响应序列化器创建的响应对象</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>

 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `HEAD` request.
 <br />使用 `HEAD` 请求创建并运行一个 `NSURLSessionDataTask`

 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes a single arguments: the data task.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有一个参数：数据任务</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>
 
 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 <br />使用 `POST` 请求创建并运行一个 `NSURLSessionDataTask`

 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和由客户端响应序列化器创建的响应对象</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>

 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a multipart `POST` request.
 <br />使用 `POST` 请求创建并运行一个<strong>上传</strong> `NSURLSessionDataTask`
 
 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param block A block that takes a single argument and appends data to the HTTP body. The block argument is an object adopting the `AFMultipartFormData` protocol.
 <ul>
 <li>该 block 接收一个参数并向 HTTP body 追加数据</li>
 <li>该 block 的参数是一个遵守 `AFMultipartFormData` 协议的对象</li>
 </ul>
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和由客户端响应序列化器创建的响应对象</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>

 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `PUT` request.
 <br />使用 `PUT` 请求创建并运行一个 `NSURLSessionDataTask`

 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和由客户端响应序列化器创建的响应对象</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>

 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `PATCH` request.
 <br />使用 `PATCH` 请求创建并运行一个 `NSURLSessionDataTask`
 
 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和由客户端响应序列化器创建的响应对象</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>

 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `DELETE` request.
 <br />使用 `DELETE` 请求创建并运行一个 `NSURLSessionDataTask`

 @param URLString The URL string used to create the request URL.
            <br />创建请求的 URL 字符串
 @param parameters The parameters to be encoded according to the client request serializer.
            <br />根据客户端请求序列化器编码的参数
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 <ul>
 <li>任务成功完成后执行的 block 对象</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和由客户端响应序列化器创建的响应对象</li>
 </ul>
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 <ul>
 <li>任务失败后执行的 block 对象</li>
 <li>或者任务成功完成，但在解析响应数据时遇到错误</li>
 <li>该 block 没有返回值</li>
 <li>该 block 有两个参数：数据任务和描述网络或解析错误的错误信息</li>
 </ul>

 @see -dataTaskWithRequest:completionHandler:
 */
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

#endif
