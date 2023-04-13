//
//  DiscoverView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 3/10/23.
//

import SwiftUI

struct DiscoverView: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0.0) {
            TopBarView()
                .padding(.horizontal, 28)
                .padding(.top, 9)
                .padding(.bottom, 30)
                .background(Color("BackgroundGreen").cornerRadius(20).edgesIgnoringSafeArea(.top))
            
            // Scanned items section
            NavigationLink {
                ScannedItemGridView()
            } label: {
                HStack {
                    Text("Recently scanned")
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 28)
                }
                .headingDiscoverTab()
                .foregroundColor(.black)
            }
            ScannedItemListView()
            
            // Store section
            Text("Nearby Stores")
                .headingDiscoverTab()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    StoreCardView(imageName: "publix-store", name: "Publix Super Market at The Plaza Midtown", location: "950 W Peachtree St NW, Atlanta, GA 30309")
                    StoreCardView(imageName: "publix-store", name: "Publix Super Market at The Plaza Midtown", location: "950 W Peachtree St NW, Atlanta, GA 30309")
                }
                .padding(.leading, 28)
            }
            
            // Sustainable section
            Text("Feeling sustainable?")
                .headingDiscoverTab()
            
            Spacer()
            
            
        }
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
        
}
