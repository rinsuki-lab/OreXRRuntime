//
//  Plugin.swift
//  Packages
//
//  Created by user on 2024/12/13.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct MacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
//        StringLiteralToCharTupleMacro.self
    ]
}
