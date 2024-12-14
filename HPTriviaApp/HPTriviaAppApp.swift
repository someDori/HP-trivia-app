//
//  HPTriviaAppApp.swift
//  HPTriviaApp
//
//  Created by Demetre Panjakidze on 11.12.24.
//

import SwiftUI

@main
struct HPTriviaAppApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
