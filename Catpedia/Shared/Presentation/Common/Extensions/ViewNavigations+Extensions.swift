//
//  ViewNavigations+Extensions.swift
//  Catpedia (iOS)
//
//  Created by Celia on 13/9/22.
//

import SwiftUI

extension View {
    
    func navigation<Item, Destination: View>(item: Binding<Item?>,
                                             @ViewBuilder destination: (Item) -> Destination ) -> some View {
        let isActive = Binding(
            get: {
                item.wrappedValue != nil
            },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }
    
    func navigation<Destination: View>(isActive: Binding<Bool>,
                                       @ViewBuilder destination: () -> Destination) -> some View {
        overlay(
            VStack(spacing: 0.0) {
                NavigationLink(
                    destination: isActive.wrappedValue ? destination() : nil,
                    isActive: isActive,
                    label: { EmptyView() }
                )
                    .isDetailLink(false)
//                Workarround https://forums.swift.org/t/14-5-beta3-navigationlink-unexpected-pop/45279/21
                NavigationLink(destination: EmptyView(), label: {})
            }
        )
    }
}
