//
//  TabBarView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 3/10/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                DiscoverView()
                    .tabItem {
                        selectedTab == 0 ? Image(systemName: "eye.circle") : Image(systemName: "eye")
                        Text("Discover")
                    }.tag(0)
                ScannerView()
                    .tabItem {
                        selectedTab == 1 ? Image(systemName: "viewfinder.circle") : Image(systemName: "viewfinder")
                        Text("Scanner")
                    }.tag(1)
                    .edgesIgnoringSafeArea(.all)
                    .toolbarBackground(.hidden, for: .tabBar)
                ScoresView()
                    .tabItem {
                        selectedTab == 2 ? Image(systemName: "cart.circle") : Image(systemName: "cart")
                        Text("Cart")
                    }.tag(2)
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
