//
//  ARSessionControl.swift
//  RecyclAR
//
//  Created by Soo Bin on 4/21/23.
//

import Foundation
import SwiftUI
import Combine

class ARSessionControl: ObservableObject {
    @Published var shouldRestart: Bool = false

    func restart() {
        shouldRestart = true
    }

    func didFinishRestarting() {
        shouldRestart = false
    }
}
