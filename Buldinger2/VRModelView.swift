//
//  VRModelView.swift
//  Buldinger2
//
//  Created by Hadi Mortazavi on 18.09.22.
//

import SwiftUI
import ARKit
import RealityKit
import FocusEntity

struct VRModelView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
    let view = ARView()

           // Start AR session
   let session = view.session
   let config = ARWorldTrackingConfiguration()
   config.planeDetection = [.horizontal]
   session.run(config)

           // Add coaching overlay
   let coachingOverlay = ARCoachingOverlayView()
   coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
   coachingOverlay.session = session
   coachingOverlay.goal = .horizontalPlane
   view.addSubview(coachingOverlay)

           // Set debug options
   #if DEBUG
   //view.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
   #endif

        context.coordinator.view = view
        session.delegate = context.coordinator
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(makeCoordinator().handleTap)
            )
        )
           return view
       }
    func makeCoordinator() -> ModelCoordinator {
        ModelCoordinator()
    }

       func updateUIView(_ view: ARView, context: Context) {
       }
    
    class ModelCoordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }

            // Create a new anchor to add content to
            let anchor = AnchorEntity()
            view.scene.anchors.append(anchor)

            // Add a Box entity with a blue material
            let box = MeshResource.generateBox(size: 0.5, cornerRadius: 0.05)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            diceEntity.position = focusEntity.position

            anchor.addChild(diceEntity)
        }
    }
}

struct VRModelView_Previews: PreviewProvider {
    static var previews: some View {
        VRModelView()
           .ignoresSafeArea()
    }
}
