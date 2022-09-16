//
//  CatpediaApp.swift
//  Shared
//
//  Created by Celia on 9/9/22.
//

import SwiftUI
import Firebase

@main
struct CatpediaApp: App {
    let coordinator = LoginCoordinator.sample
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
//            CatListView(coordinator: CatListCoordinator.sample, viewModel: MainDependencyInjector.shared.catListViewModel(coordinator: CatListCoordinator.sample))
            
            LoginView(coordinator:  coordinator, viewModel: coordinator.viewModel)
        }
    }
}
