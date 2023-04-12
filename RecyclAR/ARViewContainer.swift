//
//  ARViewContainer.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer, Soo Bin Park on 2/28/23.
//

import ARKit
import SwiftUI
import RealityKit


/// ARViewContainer holds our AR scenes provided in the Reality Project 
struct ARViewContainer: UIViewRepresentable {
    
    @State var isCoachOverlayActive = true
    @State var isIdentifying = false
    
    @State private var debugText: String = "TEST"


    func makeUIView(context: Context) -> UIView {
        return makeUIViewController(context: context).view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()

        let arView = ARView(frame: .zero)
        let cokeAnchor = try! CokeCanExplode.loadCoke()
        
        arView.addCoaching()
        arView.scene.anchors.append(cokeAnchor)
        viewController.view.addSubview(arView)
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            arView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
        
        
        let tapView = TapView()

        let tapHostingController = UIHostingController(rootView: tapView)
        tapHostingController.view.backgroundColor = .clear // Set background color to clear
        tapHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.addChild(tapHostingController)
        viewController.view.addSubview(tapHostingController.view)
        tapHostingController.didMove(toParent: viewController)
        NSLayoutConstraint.activate([
            tapHostingController.view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            tapHostingController.view.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
            
        return viewController
    }
}


extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
//        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
//        coachingOverlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        coachingOverlay.layer.cornerRadius = 20
//        coachingOverlay.clipsToBounds = true
        
        //        let coachingOverlay = ARCoachingOverlayView()
        //        coachingOverlay.delegate = Coordinator(self)
        //        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        coachingOverlay.session = arView.session
        //        coachingOverlay.goal = .horizontalPlane
        //        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        //        coachingOverlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        //        coachingOverlay.layer.cornerRadius = 20
        //        coachingOverlay.clipsToBounds = true
        //
        //        viewController.view.addSubview(coachingOverlay)
        //        NSLayoutConstraint.activate([
        //            coachingOverlay.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
        //            coachingOverlay.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
        //            coachingOverlay.widthAnchor.constraint(equalToConstant: 293.85),
        //            coachingOverlay.heightAnchor.constraint(equalToConstant: 195.17)
        //        ])

        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("[DEBUG]: coachingOverlay actived")
        self.superview?.subviews.last?.isHidden = true
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("[DEBUG]: coachingOverlay dismissed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.superview?.subviews.last?.alpha = 0.0
            } completion: { _ in
                self.superview?.subviews.last?.isHidden = false
                UIView.animate(withDuration: 0.5) {
                    self.superview?.subviews.last?.alpha = 1.0
                }
            }
        }
    }

}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ARViewContainer()
    }
}
#endif
