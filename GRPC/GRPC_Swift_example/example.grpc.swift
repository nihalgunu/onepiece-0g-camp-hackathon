//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: example.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Example_ExampleServiceClient`, then call methods of this protocol to make API calls.
internal protocol Example_ExampleServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? { get }

  func sayHello(
    _ request: Example_HelloRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Example_HelloRequest, Example_HelloReply>
}

extension Example_ExampleServiceClientProtocol {
  internal var serviceName: String {
    return "example.ExampleService"
  }

  /// Unary call to SayHello
  ///
  /// - Parameters:
  ///   - request: Request to send to SayHello.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func sayHello(
    _ request: Example_HelloRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Example_HelloRequest, Example_HelloReply> {
    return self.makeUnaryCall(
      path: Example_ExampleServiceClientMetadata.Methods.sayHello.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSayHelloInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Example_ExampleServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Example_ExampleServiceNIOClient")
internal final class Example_ExampleServiceClient: Example_ExampleServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the example.ExampleService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Example_ExampleServiceNIOClient: Example_ExampleServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the example.ExampleService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Example_ExampleServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? { get }

  func makeSayHelloCall(
    _ request: Example_HelloRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Example_HelloRequest, Example_HelloReply>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Example_ExampleServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Example_ExampleServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeSayHelloCall(
    _ request: Example_HelloRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Example_HelloRequest, Example_HelloReply> {
    return self.makeAsyncUnaryCall(
      path: Example_ExampleServiceClientMetadata.Methods.sayHello.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSayHelloInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Example_ExampleServiceAsyncClientProtocol {
  internal func sayHello(
    _ request: Example_HelloRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Example_HelloReply {
    return try await self.performAsyncUnaryCall(
      path: Example_ExampleServiceClientMetadata.Methods.sayHello.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSayHelloInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Example_ExampleServiceAsyncClient: Example_ExampleServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Example_ExampleServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Example_ExampleServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'sayHello'.
  func makeSayHelloInterceptors() -> [ClientInterceptor<Example_HelloRequest, Example_HelloReply>]
}

internal enum Example_ExampleServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "ExampleService",
    fullName: "example.ExampleService",
    methods: [
      Example_ExampleServiceClientMetadata.Methods.sayHello,
    ]
  )

  internal enum Methods {
    internal static let sayHello = GRPCMethodDescriptor(
      name: "SayHello",
      path: "/example.ExampleService/SayHello",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Example_ExampleServiceProvider: CallHandlerProvider {
  var interceptors: Example_ExampleServiceServerInterceptorFactoryProtocol? { get }

  func sayHello(request: Example_HelloRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Example_HelloReply>
}

extension Example_ExampleServiceProvider {
  internal var serviceName: Substring {
    return Example_ExampleServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SayHello":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Example_HelloRequest>(),
        responseSerializer: ProtobufSerializer<Example_HelloReply>(),
        interceptors: self.interceptors?.makeSayHelloInterceptors() ?? [],
        userFunction: self.sayHello(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Example_ExampleServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Example_ExampleServiceServerInterceptorFactoryProtocol? { get }

  func sayHello(
    request: Example_HelloRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Example_HelloReply
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Example_ExampleServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Example_ExampleServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Example_ExampleServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Example_ExampleServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SayHello":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Example_HelloRequest>(),
        responseSerializer: ProtobufSerializer<Example_HelloReply>(),
        interceptors: self.interceptors?.makeSayHelloInterceptors() ?? [],
        wrapping: { try await self.sayHello(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol Example_ExampleServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'sayHello'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSayHelloInterceptors() -> [ServerInterceptor<Example_HelloRequest, Example_HelloReply>]
}

internal enum Example_ExampleServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "ExampleService",
    fullName: "example.ExampleService",
    methods: [
      Example_ExampleServiceServerMetadata.Methods.sayHello,
    ]
  )

  internal enum Methods {
    internal static let sayHello = GRPCMethodDescriptor(
      name: "SayHello",
      path: "/example.ExampleService/SayHello",
      type: GRPCCallType.unary
    )
  }
}
