//
//  OreXRSwapchain.swift
//  OreXRRuntime
//
//  Created by user on 2024/12/14.
//

import Metal
import OSLog

class OreXRSwapchain {
    static let log = Logger(subsystem: "OreXRRuntime", category: "OreXRSwapchain")
    let textures: [MTLTexture]
    // xrCreateSwapchain
    init?(session: OreXRSession, createInfo: UnsafePointer<XrSwapchainCreateInfo>) {
        let textureDesc = MTLTextureDescriptor()
        guard createInfo.pointee.arraySize == 1 else {
            Self.log.warning("array swapchain (size=\(createInfo.pointee.arraySize) is requested, but not supported")
            return nil
        }
        guard let pixelFormat = MTLPixelFormat(rawValue: .init(createInfo.pointee.format)) else {
            Self.log.error("invalid pixel format \(createInfo.pointee.format) is requested")
            return nil
        }
        textureDesc.usage = [.renderTarget]
        textureDesc.textureType = .type2D // currently array is not supported
        textureDesc.pixelFormat = pixelFormat
        textureDesc.width = .init(createInfo.pointee.width)
        textureDesc.height = .init(createInfo.pointee.height)
        textureDesc.mipmapLevelCount = .init(createInfo.pointee.mipCount)
        Self.log.debug("TODO: usageFlags=\(createInfo.pointee.usageFlags) sampleCount=\(createInfo.pointee.sampleCount), faceCount=\(createInfo.pointee.faceCount)")
        guard let texture = session.commandQueue.device.makeTexture(descriptor: textureDesc) else {
            Self.log.error("failed to create texture")
            return nil
        }
        textures = [texture]
    }
}
