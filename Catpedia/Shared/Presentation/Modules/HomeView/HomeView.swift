//
//  TabView.swift
//  Catpedia (iOS)
//
//  Created by Celia on 13/9/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var coordinator: HomeCoordinator
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        TabView  {
            CatListView(coordinator: coordinator.catListCoordinator, viewModel: coordinator.catListCoordinator.viewModel)
                .tabItem {
                    Label("Cats", systemImage: "list.dash")}
                .onAppear(){
                    coordinator.catListCoordinator.viewModel.getFavoriteList()
                }
            
            FavoriteListView(viewModel: coordinator.favoriteListCoordinator.viewModel, coordinator: coordinator.favoriteListCoordinator)
                .tabItem {
                    Label("Favs", systemImage: "heart")}
                .onAppear(){
                    coordinator.favoriteListCoordinator.viewModel.getFavoriteList()
                }
            
            LogOutView(coordinator: coordinator.logOutCoordinator, viewModel: coordinator.logOutCoordinator.viewModel)
                .tabItem {
                    Label("LogOut", systemImage: "hand.wave.fill")}
        }.accentColor(.principalPink)
    }
}
