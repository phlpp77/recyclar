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
    @State var state: TapView.TapViewState
    
    
    let cokeAnchor = try! CokeCanExplode.loadGVU()
    

    func makeUIView(context: Context) -> UIView {
        return makeUIViewController(context: context).view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tapView = TapView(state: $state)

        let arView = ARView(frame: .zero)
        //let cokeAnchor = try! CokeCanExplode.loadCoke()
        let cokeNormal = cokeAnchor.findEntity(named: "CokeNormal")
        let cokeExplode = cokeAnchor.findEntity(named: "CokeExplode")
        let cokeClose = cokeAnchor.findEntity(named: "CokeClose")
        
        cokeNormal?.isEnabled = false
        cokeExplode?.isEnabled = false
        cokeClose?.isEnabled = false
        
//        cokeAnchor.notifications.explode.post()
//        cokeAnchor.notifications.close.post()

        
        arView.addCoaching()
        arView.scene.anchors.append(cokeAnchor)
        
        
        // Add object detection for `CokeCanExplode`
        
        arView.session.delegate = context.coordinator
        
        
        viewController.view.addSubview(arView)
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            arView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
    

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
    
    class Coordinator: NSObject, ARSessionDelegate {

            var parent: ARViewContainer
            var cokeNormal: Entity?
            var cokeExplode: Entity?
            var cokeClose: Entity?

            init(_ parent: ARViewContainer) {
                self.parent = parent
            }

            // MARK: - ARSessionDelegate
            func session(_ session: ARSession, didFailWithError error: Error) {}

            func sessionWasInterrupted(_ session: ARSession) {}

            func sessionInterruptionEnded(_ session: ARSession) {}

            func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
                for anchor in anchors {
                    
                    // Change the tap view state to `.scanned` if it is currently in the `.identifying` state.
                    if let objectAnchor = anchor as? ARObjectAnchor {
                        print("Detected object with name: \(objectAnchor.referenceObject.name ?? "")")
                        
                        print(parent.state)
                        
                        cokeExplode = self.parent.cokeAnchor.findEntity(named: "CokeExplode")
                        cokeClose = self.parent.cokeAnchor.findEntity(named: "CokeClose")

                        if parent.state == .identifying || parent.state == .tapToPosition {
                            
                            cokeExplode?.isEnabled = true
                            //cokeClose?.isEnabled = true
                            
//                            self.parent.cokeAnchor.notifications.explode.post() //trigger action sequence
//                            self.parent.cokeAnchor.notifications.close.post()
                            
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                self.parent.state = .scanned
//                            }
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.parent.state = .objectFound
                                
                            }
                            
                        }
                        
                        
                    }
                
                }
            }
        }

        func makeCoordinator() -> Coordinator {
            return Coordinator(self)
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
        //coachingOverlay.activatesAutomatically = true
        self.superview?.subviews.last?.isHidden = true
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //coachingOverlayView.activatesAutomatically = false
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

//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ARViewContainer(, state: <#TapView.TapViewState#>)
//    }
//}
//#endif
