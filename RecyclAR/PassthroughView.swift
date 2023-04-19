//
//  PassthroughView.swift
//  RecyclAR
//
//  Created by Soo Bin on 4/19/23.
//

import Foundation
import SwiftUI

class PassthroughView: UIView {
    var shouldPassthroughTouches = false
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if shouldPassthroughTouches {
            return nil
        } else {
            return super.hitTest(point, with: event)
        }
    }
}

struct PassthroughTapView: UIViewRepresentable {
    @Binding var shouldPassthroughTouches: Bool
    let content: () -> TapView
    
    func makeUIView(context: Context) -> PassthroughView {
        let passthroughView = PassthroughView()
        passthroughView.shouldPassthroughTouches = shouldPassthroughTouches
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        passthroughView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: passthroughView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: passthroughView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: passthroughView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: passthroughView.bottomAnchor)
        ])
        
        return passthroughView
    }
    
    func updateUIView(_ uiView: PassthroughView, context: Context) {
        uiView.shouldPassthroughTouches = shouldPassthroughTouches
    }
}
