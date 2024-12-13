//
//  OreXRSession.swift
//  OreXRRuntime
//
//  Created by user on 2024/12/13.
//

import Metal

class OreXRSession {
    let commandQueue: MTLCommandQueue
    
    init(commandQueue: MTLCommandQueue) {
        self.commandQueue = commandQueue
    }
}
