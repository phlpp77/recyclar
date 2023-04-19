//
//  TapHostingControllerHolder.swift
//  RecyclAR
//
//  Created by Soo Bin on 4/19/23.
//

import Foundation
import SwiftUI

class TapHostingControllerHolder: ObservableObject {
    @Published var tapHostingController: UIHostingController<TapView>?
}
