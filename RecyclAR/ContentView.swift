//
//  ContentView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer, Soo Bin Park on 2/28/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let cokeAnchor = try! CokeCanExplode.loadCoke()
        let speech = cokeAnchor.findEntity(named: "Speech")
        
        speech?.isEnabled = false
        
        let buddhaAnchor = try! CokeCanExplode.loadBuddha()
        
        // self.cokeAnchor?.notifications.triggerEx01.post() //trigger action sequence
        
        /// Configure how we behave when certain actions are triggered
//        cokeAnchor.actions.explode.onAction = { _ in
//            self.doSomething()
//        }
        
        // Add the coke and buddha anchor to the scene
        arView.scene.anchors.append(cokeAnchor)
        arView.scene.anchors.append(buddhaAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
