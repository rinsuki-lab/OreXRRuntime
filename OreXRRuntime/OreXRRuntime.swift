//
//  OreXRRuntime.swift
//  OreXRRuntime
//
//  Created by user on 2024/12/13.
//

import OreXRMacros
import os.log
import Metal

// Type your code here, or load an example.

let log = Logger(subsystem: "OreXR.Runtime", category: "RuntimeRoot")

extension XrVersion {
    public var readable: String {
        return "\(self >> 48).\(self >> 32 & 0xFFFF).\(self & 0xFFFFFFFF)"
    }
}

typealias ConstCharPtr = UnsafePointer<Int8>?

func orexrGetInstanceProcAddr(instance: XrInstance?, name: ConstCharPtr, fn: UnsafeMutablePointer<PFN_xrVoidFunction?>?) -> XrResult {
    guard let name = name.map({ String(cString: $0) }) else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let fn else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    
    log.debug("orexrGetInstanceProcAddr \(name)")
    switch name {
    case "xrEnumerateInstanceExtensionProperties":
        fn.pointee = unsafeBitCast(orexrEnumerateInstanceExtensionProperties, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrCreateInstance":
        fn.pointee = unsafeBitCast(orexrCreateInstance, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrGetSystem":
        fn.pointee = unsafeBitCast(orexrGetSystem, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrGetSystemProperties":
        fn.pointee = unsafeBitCast(orexrGetSystemProperties, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrDestroyInstance":
        fn.pointee = unsafeBitCast(orexrDestroyInstance, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrGetInstanceProperties":
        fn.pointee = unsafeBitCast(orexrGetInstanceProperties, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEnumerateEnvironmentBlendModes":
        fn.pointee = unsafeBitCast(orexrEnumerateEnvironmentBlendModes, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEnumerateViewConfigurations":
        fn.pointee = unsafeBitCast(orexrEnumerateViewConfigurations, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrGetViewConfigurationProperties":
        fn.pointee = unsafeBitCast(orexrGetViewConfigurationProperties, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEnumerateViewConfigurationViews":
        fn.pointee = unsafeBitCast(orexrEnumerateViewConfigurationViews, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrGetMetalGraphicsRequirementsKHR":
        fn.pointee = unsafeBitCast(orexrGetMetalGraphicsRequirementsKHR, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrCreateSession":
        fn.pointee = unsafeBitCast(orexrCreateSession, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEnumerateReferenceSpaces":
        fn.pointee = unsafeBitCast(orexrEnumerateReferenceSpaces, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrCreateReferenceSpace":
        fn.pointee = unsafeBitCast(orexrCreateReferenceSpace, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEnumerateSwapchainFormats":
        fn.pointee = unsafeBitCast(orexrEnumerateSwapchainFormats, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrCreateSwapchain":
        fn.pointee = unsafeBitCast(orexrCreateSwapchain, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEnumerateSwapchainImages":
        fn.pointee = unsafeBitCast(orexrEnumerateSwapchainImages, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrPollEvent":
        fn.pointee = unsafeBitCast(orexrPollEvent, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrBeginSession":
        fn.pointee = unsafeBitCast(orexrBeginSession, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrWaitFrame":
        fn.pointee = unsafeBitCast(orexrWaitFrame, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrBeginFrame":
        fn.pointee = unsafeBitCast(orexrBeginFrame, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrEndFrame":
        fn.pointee = unsafeBitCast(orexrEndFrame, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrLocateViews":
        fn.pointee = unsafeBitCast(orexrLocateViews, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrLocateSpace":
        fn.pointee = unsafeBitCast(orexrLocateSpace, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrAcquireSwapchainImage":
        fn.pointee = unsafeBitCast(orexrAcquireSwapchainImage, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrWaitSwapchainImage":
        fn.pointee = unsafeBitCast(orexrWaitSwapchainImage, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    case "xrReleaseSwapchainImage":
        fn.pointee = unsafeBitCast(orexrReleaseSwapchainImage, to: PFN_xrVoidFunction.self)
        return XR_SUCCESS
    default:
        log.warning("UNKNOWN function requested, \(name)")
        fn.pointee = nil
        return XR_ERROR_FUNCTION_UNSUPPORTED
    }
}

let orexrEnumerateInstanceExtensionProperties: PFN_xrEnumerateInstanceExtensionProperties = { (layerName, capIn, capOut, properties) in
    log.debug("xrEnumerateInstanceExtensionProperties: requested with \(layerName.map({ String(cString: $0) }) ?? "nil"), \(capIn)")
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }

    capOut.pointee = 1
    if capIn == 0 { // requests length
        return XR_SUCCESS
    }
    
    guard let properties else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    
    properties.pointee = .init(type: XR_TYPE_EXTENSION_PROPERTIES, next: nil, extensionName: OREXR_EXTNAME_XR_KHR_metal_enable, extensionVersion: 1)
    
    return XR_SUCCESS
}

let orexrCreateInstance: PFN_xrCreateInstance = { (createInfo, instance) in
    log.debug("xrCreateInstance: requested")
    guard let createInfo = createInfo else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let instance else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    
    var appNameRaw = createInfo.pointee.applicationInfo.applicationName
    
    let appName = withUnsafeBytes(of: &appNameRaw) { ptr in
        String(cString: ptr.baseAddress!.assumingMemoryBound(to: CChar.self))
    }
    log.info("xrCreateInstance: creating (appName=\(appName))")
    
    let inst = OreXRInstance()
    instance.pointee = .init(Unmanaged.passRetained(inst).toOpaque())
    
    return XR_SUCCESS
}

let orexrDestroyInstance: PFN_xrDestroyInstance = { instance in
    log.info("xrDestroyInstance: called")
    guard let instance else {
        return XR_ERROR_HANDLE_INVALID
    }
    let me = Unmanaged<OreXRInstance>.fromOpaque(.init(instance)).takeRetainedValue()
    return XR_SUCCESS
}

let orexrGetSystem: PFN_xrGetSystem = { (instance, getInfo, systemId) in
    guard let getInfo else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let instance else {
        return XR_ERROR_HANDLE_INVALID
    }
    let me = Unmanaged<OreXRInstance>.fromOpaque(.init(instance)).takeUnretainedValue()
    guard getInfo.pointee.formFactor == XR_FORM_FACTOR_HEAD_MOUNTED_DISPLAY else {
        return XR_ERROR_FORM_FACTOR_UNSUPPORTED
    }
    systemId?.pointee = 1

    return XR_SUCCESS
}

let orexrGetSystemProperties: PFN_xrGetSystemProperties = { (instance, systemId, properties) in
    guard let properties else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    properties.pointee = .init(
        type: XR_TYPE_SYSTEM_PROPERTIES,
        next: nil,
        systemId: 1, vendorId: 0,
        systemName: OREXR_SYSTEM_NAME,
        graphicsProperties: .init(maxSwapchainImageHeight: 4096, maxSwapchainImageWidth: 4096, maxLayerCount: 4),
        trackingProperties: .init(orientationTracking: 0, positionTracking: 0)
    )
    
    return XR_SUCCESS
}

let orexrGetInstanceProperties: PFN_xrGetInstanceProperties = { (instance, props) in
    guard let props else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    props.pointee = .init(type: XR_TYPE_INSTANCE_PROPERTIES, next: nil, runtimeVersion: 1, runtimeName: OREXR_RUNTIME_NAME)
    return XR_SUCCESS
}


let orexrEnumerateEnvironmentBlendModes: PFN_xrEnumerateEnvironmentBlendModes = { (instance, systemId, viewConfigType, capIn, capOut, blendModes) in
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    capOut.pointee = 1
    if capIn == 0 {
        return XR_SUCCESS
    }
    guard let blendModes else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    blendModes.pointee = XR_ENVIRONMENT_BLEND_MODE_OPAQUE
    return XR_SUCCESS
}

let orexrEnumerateViewConfigurations: PFN_xrEnumerateViewConfigurations = { (instance, systemId, capIn, capOut, types) in
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    capOut.pointee = 1
    if capIn == 0 {
        return XR_SUCCESS
    }
    guard let types else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    types.pointee = XR_VIEW_CONFIGURATION_TYPE_PRIMARY_STEREO
    return XR_SUCCESS
}

let orexrGetViewConfigurationProperties: PFN_xrGetViewConfigurationProperties = { (instance, systemId, viewConfigType, props) in
    guard let props else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard viewConfigType == XR_VIEW_CONFIGURATION_TYPE_PRIMARY_STEREO else {
        return XR_ERROR_VIEW_CONFIGURATION_TYPE_UNSUPPORTED
    }
    props.pointee = .init(
        type: XR_TYPE_VIEW_CONFIGURATION_PROPERTIES, next: nil,
        viewConfigurationType: XR_VIEW_CONFIGURATION_TYPE_PRIMARY_STEREO, fovMutable: 0
    )
    return XR_SUCCESS
}

let orexrEnumerateViewConfigurationViews: PFN_xrEnumerateViewConfigurationViews = { (instance, systemId, configType, capIn, capOut, views) in
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    capOut.pointee = 2
    if capIn == 0 {
        return XR_SUCCESS
    }
    if capIn != capOut.pointee {
        return XR_ERROR_SIZE_INSUFFICIENT
    }
    guard let views else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    views[0] = .init(type: XR_TYPE_VIEW_CONFIGURATION_VIEW, next: nil, recommendedImageRectWidth: 2048, maxImageRectWidth: 4096, recommendedImageRectHeight: 2048, maxImageRectHeight: 4096, recommendedSwapchainSampleCount: 2, maxSwapchainSampleCount: 4)
    views[1] = views[0]
    
    return XR_SUCCESS
}

let orexrGetMetalGraphicsRequirementsKHR: PFN_xrGetMetalGraphicsRequirementsKHR = { (instance, systemId, metalRequirements) in
    guard let metalRequirements else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let device = MTLCreateSystemDefaultDevice() else {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    
    metalRequirements.pointee = .init(type: XR_TYPE_GRAPHICS_REQUIREMENTS_METAL_KHR, next: nil, metalDevice: Unmanaged.passRetained(device).toOpaque())
    return XR_SUCCESS
}

let orexrCreateSession: PFN_xrCreateSession = { (instance, createInfo, session) in
    guard let instance else {
        return XR_ERROR_HANDLE_INVALID
    }
    let me = Unmanaged<OreXRInstance>.fromOpaque(.init(instance)).takeUnretainedValue()
    guard let createInfo else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let session else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let nextRaw = createInfo.pointee.next else {
        log.error("xrCreateSession: no next info, reject")
        return XR_ERROR_VALIDATION_FAILURE
    }
    let next = nextRaw.assumingMemoryBound(to: XrGraphicsBindingMetalKHR.self)
    if next.pointee.type != XR_TYPE_GRAPHICS_BINDING_METAL_KHR {
        log.error("xrCreateSession: next info is not MetalKHR, reject")
        return XR_ERROR_VALIDATION_FAILURE
    }
    let commandQueue = Unmanaged<MTLCommandQueue>.fromOpaque(next.pointee.commandQueue).takeUnretainedValue()
    guard let oreSession = me.createSession(commandQueue: commandQueue) else {
        return XR_ERROR_RUNTIME_FAILURE
    }
    session.pointee = .init(Unmanaged.passRetained(oreSession).toOpaque())
    return XR_SUCCESS
}

let orexrEnumerateReferenceSpaces: PFN_xrEnumerateReferenceSpaces = { (session, capIn, capOut, spaces) in
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    capOut.pointee = 1
    if capIn == 0 {
        return XR_SUCCESS
    }
    guard let spaces else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    spaces.pointee = XR_REFERENCE_SPACE_TYPE_LOCAL
    return XR_SUCCESS
}

let orexrCreateReferenceSpace: PFN_xrCreateReferenceSpace = { (session, createInfo, space) in
    guard let createInfo else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let space else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    let oreSpace = OreXRReferenceSpace()
    space.pointee = .init(Unmanaged.passRetained(oreSpace).toOpaque())
    return XR_SUCCESS
}

let orexrEnumerateSwapchainFormats: PFN_xrEnumerateSwapchainFormats = { (session, capIn, capOut, formats) in
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    capOut.pointee = 1
    if capIn == 0 {
        return XR_SUCCESS
    }
    guard let formats else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    formats.pointee = .init(MTLPixelFormat.rgba8Unorm.rawValue)
    return XR_SUCCESS
}

let orexrCreateSwapchain: PFN_xrCreateSwapchain = { (session, createInfo, swapchain) in
    guard let session = session else {
        return XR_ERROR_HANDLE_INVALID
    }
    let sessionSelf = Unmanaged<OreXRSession>.fromOpaque(.init(session)).takeUnretainedValue()
    guard let createInfo else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let swapchain else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let oreSwapchain = OreXRSwapchain(session: sessionSelf, createInfo: createInfo) else {
        return XR_ERROR_RUNTIME_FAILURE
    }
    swapchain.pointee = .init(Unmanaged.passRetained(oreSwapchain).toOpaque())
    return XR_SUCCESS
}

let orexrEnumerateSwapchainImages: PFN_xrEnumerateSwapchainImages = { (swapchain, capIn, capOut, images) in
    guard let capOut else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let swapchain else {
        return XR_ERROR_HANDLE_INVALID
    }
    let swapchainSelf = Unmanaged<OreXRSwapchain>.fromOpaque(.init(swapchain)).takeUnretainedValue()
    capOut.pointee = .init(swapchainSelf.textures.count)
    if capIn == 0 {
        return XR_SUCCESS
    }
    guard let images else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    images.withMemoryRebound(to: XrSwapchainImageMetalKHR.self, capacity: .init(capIn), { pointer in
        for i in 0..<capOut.pointee {
            pointer[Int(i)] = XrSwapchainImageMetalKHR(
                type: XR_TYPE_SWAPCHAIN_IMAGE_METAL_KHR,
                next: nil,
                texture: Unmanaged.passRetained(swapchainSelf.textures[Int(i)]).toOpaque()
            )
        }
    })
    return XR_SUCCESS
}

let orexrPollEvent: PFN_xrPollEvent = { instance, eventBuffer in
    guard let instance = instance else {
        return XR_ERROR_HANDLE_INVALID
    }
    guard let eventBuffer else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    let me = Unmanaged<OreXRInstance>.fromOpaque(.init(instance)).takeUnretainedValue()
    return me.pollEvent(eventBuffer: eventBuffer)
}

let orexrBeginSession: PFN_xrBeginSession = { session, beginInfo in
    return XR_SUCCESS
}

let orexrWaitFrame: PFN_xrWaitFrame = { session, frameWaitInfo, frameState in
    guard let frameState else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    frameState.pointee.shouldRender = 1
    frameState.pointee.predictedDisplayPeriod = 8 * 1000
    sleep(1)
    return XR_SUCCESS
}

let orexrBeginFrame: PFN_xrBeginFrame = { session, frameBeginInfo in
    return XR_SUCCESS
}

let orexrEndFrame: PFN_xrEndFrame = { session, frameEndInfo in
    return XR_SUCCESS
}

let orexrLocateViews: PFN_xrLocateViews = { session, locateInfo, state, capInput, capOutput, views in
    guard capInput == 2 else {
        // not stereo?
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let capOutput else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let views else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    guard let state else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    
    capOutput.pointee = 2
    
    for i in 0..<2 {
        views[i].fov = .init(angleLeft: -0.5, angleRight: 0.5, angleUp: -0.5, angleDown: 0.5)
        views[i].pose = .init(orientation: .init(x: 0, y: 0, z: 0, w: 0), position: .init(x: 0, y: 1, z: 0.1))
    }
    state.pointee.viewStateFlags = XR_VIEW_STATE_POSITION_VALID_BIT | XR_VIEW_STATE_ORIENTATION_VALID_BIT
    
    return XR_SUCCESS
}

let orexrLocateSpace: PFN_xrLocateSpace = { space, baseSpace, time, location in
    guard let location else {
        return XR_ERROR_VALIDATION_FAILURE
    }
    location.pointee.locationFlags = XR_SPACE_LOCATION_POSITION_VALID_BIT | XR_SPACE_LOCATION_ORIENTATION_VALID_BIT
    location.pointee.pose = .init(orientation: .init(x: 0, y: 0, z: 0, w: 0), position: .init(x: 0, y: 1, z: 0))
    return XR_SUCCESS
}

let orexrAcquireSwapchainImage: PFN_xrAcquireSwapchainImage = { swapchain, acquireInfo, index in
    index?.pointee = 0 // ??
    return XR_SUCCESS
}

let orexrWaitSwapchainImage: PFN_xrWaitSwapchainImage = { swapchain, waitInfo in
    return XR_SUCCESS
}

let orexrReleaseSwapchainImage: PFN_xrReleaseSwapchainImage = { swapchain, releaseInfo in
    return XR_SUCCESS
}

@_cdecl("orexrNegotiateLoaderRuntimeInterface")
func orexrNegotiateLoaderRuntimeInterface(loaderInfo: UnsafePointer<XrNegotiateLoaderInfo>, runtimeRequest: UnsafeMutablePointer<XrNegotiateRuntimeRequest>) -> XrResult {
    if loaderInfo.pointee.structType != XR_LOADER_INTERFACE_STRUCT_LOADER_INFO {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    if loaderInfo.pointee.structVersion != XR_LOADER_INFO_STRUCT_VERSION {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    if loaderInfo.pointee.structSize != MemoryLayout<XrNegotiateLoaderInfo>.size {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    
    if runtimeRequest.pointee.structType != XR_LOADER_INTERFACE_STRUCT_RUNTIME_REQUEST {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    if runtimeRequest.pointee.structVersion != XR_RUNTIME_INFO_STRUCT_VERSION {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    if runtimeRequest.pointee.structSize != MemoryLayout<XrNegotiateRuntimeRequest>.size {
        return XR_ERROR_INITIALIZATION_FAILED
    }
    
    // TODO: validates API and Interface version
    log.info("Loader requests API \(loaderInfo.pointee.minApiVersion.readable)..\(loaderInfo.pointee.maxApiVersion.readable)")
    log.info("Loader requests Interface \(loaderInfo.pointee.minInterfaceVersion)..\(loaderInfo.pointee.maxInterfaceVersion)")
    runtimeRequest.pointee.runtimeApiVersion = loaderInfo.pointee.minApiVersion
    runtimeRequest.pointee.runtimeInterfaceVersion = loaderInfo.pointee.minInterfaceVersion
    runtimeRequest.pointee.getInstanceProcAddr = orexrGetInstanceProcAddr
    
    return XR_SUCCESS
}
