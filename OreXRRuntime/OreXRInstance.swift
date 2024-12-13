//
//  OreXRInstance.swift
//  OreXRRuntime
//
//  Created by user on 2024/12/13.
//

import Metal

class OreXRInstance {
    var ready: Bool = false
    var session: OreXRSession?
    
    func createSession(commandQueue: MTLCommandQueue) -> OreXRSession? {
        if session != nil {
            return nil
        }
        session = OreXRSession(commandQueue: commandQueue)
        return session
    }
    
    func pollEvent(eventBuffer: UnsafeMutablePointer<XrEventDataBuffer>) -> XrResult {
        if !ready, let session {
            ready = true
            let eb = eventBuffer.withMemoryRebound(to: XrEventDataSessionStateChanged.self, capacity: 1) { pointer in
                pointer.pointee.type = XR_TYPE_EVENT_DATA_SESSION_STATE_CHANGED
                pointer.pointee.next = nil
                pointer.pointee.session = .init(Unmanaged<OreXRSession>.passUnretained(session).toOpaque())
                pointer.pointee.state = XR_SESSION_STATE_READY
                pointer.pointee.time = 0
            }
            return XR_SUCCESS
        }
        return XR_EVENT_UNAVAILABLE
    }
}
