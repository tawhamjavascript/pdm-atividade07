//
//  pratica07App.swift
//  pratica07
//
//  Created by Taw-ham Balbino on 12/12/23.
//

import SwiftUI

@main
struct pratica07App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
