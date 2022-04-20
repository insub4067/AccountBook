//
//  AccountBookApp.swift
//  AccountBook
//
//  Created by Kim Insub on 2022/04/19.
//

import SwiftUI

@main
struct AccountBookApp: App {
    
    @StateObject private var accountDataController = AccountDataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, accountDataController.container.viewContext)
        }
    }
}
