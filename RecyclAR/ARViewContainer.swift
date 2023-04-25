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
    @State var customText = "Tap the object for more sustainability information"

    //@State var tapHostingController: UIHostingController<TapView>?
    //@State var tapHostingController: UIHostingController<TapView> = UIHostingController(rootView: TapView(state: .constant(TapView.TapViewState.tapToPosition)))
    @StateObject var tapHostingControllerHolder = TapHostingControllerHolder()
    

    
    //@State var tapHostingControllerView: UIView? // Add this line

    
    
    let cokeAnchor = try! CokeCanGVU.loadCoke()
    let pastaAnchor = try! CokeCanGVU.loadPasta()
    
    
    

    func makeUIView(context: Context) -> UIView {
        return makeUIViewController(context: context).view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIViewController(context: Context) -> UIViewController {
        
        let viewController = UIViewController()
        //let tapView = TapView(state: $state)
        let tapView = TapView(state: $state, customText: $customText)

        
    


        let arView = ARView(frame: .zero)
        //let cokeAnchor = try! CokeCanExplode.loadCoke()
        //let cokeNormal = cokeAnchor.findEntity(named: "CokeNormal")
        let cokeExplode = cokeAnchor.findEntity(named: "CokeExplode")
        let cokeClose = cokeAnchor.findEntity(named: "CokeClose")
        let cokeEco = cokeAnchor.findEntity(named: "CokeEco")
        let tag = cokeAnchor.findEntity(named: "Tag")
        
        let pastaExplode = pastaAnchor.findEntity(named: "PastaExplode")
        let pastaClose = pastaAnchor.findEntity(named: "PastaClose")
        let pastaEco = pastaAnchor.findEntity(named: "PastaEco")
        let pastaTag = pastaAnchor.findEntity(named: "Tag")
        
        //cokeNormal?.isEnabled = false
        cokeExplode?.isEnabled = false
        cokeClose?.isEnabled = false
        cokeEco?.isEnabled = false
        tag?.isEnabled = false
        
        pastaExplode?.isEnabled = false
        pastaClose?.isEnabled = false
        pastaEco?.isEnabled = false
        pastaTag?.isEnabled = false
        
        
        
        
//        cokeAnchor.actions.wait.onAction = { entity in
//            self.displaySustainability(entity, text: "")
//        }
        
        
        cokeAnchor.actions.waitCoke.onAction = { entity in
            self.displaySustainability(entity, text: "")
        }
        
        pastaAnchor.actions.waitPasta.onAction = { entity in
            self.displaySustainability(entity, text: "")
        }
        
        cokeAnchor.actions.showEco.onAction = { entity in
            self.displaySustainability(entity, text: "The product has a sustainability score of 80 points.\nTap the product if you want to add it to your cart.")
        }
        
        pastaAnchor.actions.showPasta.onAction = { entity in
            self.displaySustainability(entity, text: "The product has a sustainability score of 60 points.\nTap the product if you want to add it to your cart.")
        }
        
        cokeAnchor.actions.tapEcocoke.onAction = { entity in
            self.addCoke(entity, text: "")
        }
        
        
        pastaAnchor.actions.tapEcopasta.onAction = { entity in
            self.addPasta(entity, text: "")
        }
        
        
//        cokeAnchor.notifications.explode.post()
//        cokeAnchor.notifications.close.post()
        
        arView.addCoaching()
        arView.scene.anchors.append(cokeAnchor)
        arView.scene.anchors.append(pastaAnchor)
        
        
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
    

        tapHostingControllerHolder.tapHostingController = UIHostingController(rootView: tapView)
        tapHostingControllerHolder.tapHostingController?.view.backgroundColor = .clear
        tapHostingControllerHolder.tapHostingController?.view.translatesAutoresizingMaskIntoConstraints = false
        //tapHostingControllerHolder.tapHostingController?.view.isUserInteractionEnabled = false
        
        if let tapHostingController =  tapHostingControllerHolder.tapHostingController {
            viewController.addChild(tapHostingController)
            viewController.view.addSubview(tapHostingController.view)
            tapHostingController.didMove(toParent: viewController)
            
            
            NSLayoutConstraint.activate([
                tapHostingController.view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                tapHostingController.view.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: -30) // adjust the constant as needed
                //tapHostingController.view.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 50)
            ])
        }
            
        return viewController
    }
    
    
    func displaySustainability(_ entity: Entity?, text: String) {
        print("Show sustainability score")
        customText = text
            
        guard let entity = entity else { return }
        // Do something with entity...
    }
    
    func addPasta(_ entity: Entity?, text: String) {
        print("Added to Cart")
        customText = text
            
        guard let entity = entity else { return }
        // Do something with entity...
        
        // Add a new product to the array
        let newProduct = Product(name: "Pasta", imageName: "pasta", sustainabilityPoints: 60, price: 1.0)
        Product.all.append(newProduct)
        
        // Add the new product to the CartItem array
        let newCartItem = CartItem(product: newProduct, count: 1)
        CartItem.all.append(newCartItem)
    }
    
    func addCoke(_ entity: Entity?, text: String) {
        print("Added to Cart")
        customText = text
            
        guard let entity = entity else { return }
        // Do something with entity...
        
        // Add a new product to the array
        let newProduct = Product(name: "Coke", imageName: "coke", sustainabilityPoints: 80, price: 1.0)
        Product.all.append(newProduct)
        
        // Add the new product to the CartItem array
        let newCartItem = CartItem(product: newProduct, count: 1)
        CartItem.all.append(newCartItem)
    }
    
    
    class Coordinator: NSObject, ARSessionDelegate {

            var parent: ARViewContainer
            var cokeNormal: Entity?
            var cokeExplode: Entity?
            var cokeClose: Entity?
        
            var pastaNormal: Entity?
            var pastaExplode: Entity?
            var pastaClose: Entity?

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
                        //print("Detected object with name: \(objectAnchor.referenceObject.name ?? "")")
                                                
                        cokeExplode = self.parent.cokeAnchor.findEntity(named: "CokeExplode")
                        pastaExplode = self.parent.pastaAnchor.findEntity(named: "PastaExplode")
                        

                        if parent.state == .identifying || parent.state == .tapToPosition {
                            
                            self.cokeExplode?.isEnabled = true
                            self.parent.state = .objectFound
                            
                            self.pastaExplode?.isEnabled = true
                            self.parent.state = .objectFound
                            
                            parent.tapHostingControllerHolder.tapHostingController?.view.isUserInteractionEnabled = false

                            
//                            DispatchQueue.main.async {
//                                self.parent.state = .objectFound
//                                self.cokeExplode?.isEnabled = true
//                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                // your code here
                                
                                self.parent.state = .nothing
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
