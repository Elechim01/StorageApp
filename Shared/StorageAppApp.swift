//
//  StorageAppApp.swift
//  Shared
//
//  Created by Michele Manniello on 12/09/21.
//

import SwiftUI

@main
struct StorageAppApp: App {
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
        }
//        Hidding title Bar..
        .windowStyle(HiddenTitleBarWindowStyle())
        #else
        WindowGroup {
            ContentView()
        }
        #endif
    }
}

#if os(macOS)
//Hidding Focus Ring...
extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}
#endif
