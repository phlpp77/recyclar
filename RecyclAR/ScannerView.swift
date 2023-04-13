//
//  ScannerView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 3/10/23.
//

import SwiftUI

struct ScannerView: View {
    @State private var tapViewState: TapView.TapViewState = .tapToPosition

    var body: some View {
        ARViewContainer(state: tapViewState)
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
