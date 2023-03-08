//
//  ARView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/6/23.
//

//import SwiftUI
//import ARKit
//
//protocol ARViewDelegate: AnyObject {
//    //
//}
//
//struct ARView: UIViewRepresentable {
//    
//    let sceneView: ARSCNView
//    let scene: SCNScene
//    weak var delegate: ARViewDelegate?
//    
//    init(withScene scene: SCNScene, delegate: ARViewDelegate){
//        
//        self.sceneView = ARSCNView()
//        self.scene = scene
//        
//        self.delegate = delegate
//    }
//    
//    func makeUIView(context: Context) -> some ARSCNView {
//        sceneView.showsStatistics = true
//        sceneView.delegate = context.coordinator
//        
//        sceneView.scene = scene
//        
//        let config = ARWorldTrackingConfiguration()
//        config.planeDetection = .horizontal
//        sceneView.session.run(config)
//        
//        return sceneView
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        //
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(arView: self)
//    }
//    
//    class Coordinator: UIViewController, ARSCNViewDelegate {
//        
//        var arView: ARView?
//        
//        init(arView: ARView) {
//            self.arView = arView
//            super.init(nibName: nil, bundle: nil)
////            setupGestures()
//        }
//        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//        
////        private func setupGestures(){
////            let tapGestureRecognizer = UITapGestureRecognizer(target: self,
////                                                              action: #selector(Self.handleTap))
////            parent?.sceneView.addGestureRecognizer(tapGestureRecognizer)
////        }
////
////        @objc func handleTap(sender: UITapGestureRecognizer) {
////            guard let sceneView = parent?.sceneView else { return }
////            let location = sender.location(in: sceneView)
//////
////            // Perform raycast query
////            if let query = sceneView.raycastQuery(from: location, allowing: .existingPlaneGeometry, alignment: .vertical) {
////                let raycastResults = sceneView.session.raycast(query)
////
////                // Perform hit test on first raycast result
////                if let result = raycastResults.first {
////                    let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
////
////                    let position = result.worldTransform.columns.3
////                    let hitTestPoint = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
////
////                    guard let node = sceneView.hitTest(hitTestPoint, options: hitTestOptions).first?.node else {
////                        print("No nodes found at hit test location")
////                        return
////                    }
////
////                    // Check if node is one of your objects
////                    if let objectNode = node.parent?.parent, objectNode.name == parent?.scene.rootNode.name {
////                        // Select object (e.g. change appearance)
////                        objectNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
////                    } else if let scene = parent?.scene {
////                        // Create a new object and place it on the detected plane
////                        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
////                        let boxNode = SCNNode(geometry: scene.rootNode.geometry)
////                        boxNode.position = SCNVector3(hitTestPoint.x, hitTestPoint.y, CGFloat(position.z))
////                        parent?.sceneView.scene.rootNode.addChildNode(boxNode)
////
////                    }
////
////
////                } else {
////                    print("No raycast results found")
////                }
////            }
////
////        }
//        
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            Logging.LogMe("... began")
//            guard let touch = touches.first, let sceneView = arView?.sceneView else { return }
//            
//            guard let query = sceneView.raycastQuery(from: touch.location(in: sceneView),
//                                                     allowing: .existingPlaneGeometry,
//                                                     alignment: .vertical) else {
//                return
//            }
//            Logging.LogMe("... cast")
//
//            let raycastResults = sceneView.session.raycast(query)
//            guard let hitFeature = raycastResults.last else { return }
//            let hitTransform = SCNMatrix4.init(hitFeature.worldTransform)
//            let hitPosition = SCNVector3Make(hitTransform.m41,
//                                             hitTransform.m42,
//                                             hitTransform.m43)
//            createBall(hitPosition: hitPosition)
//        }
//        func createBall(hitPosition : SCNVector3) {
//            Logging.LogMe("... 0")
//            guard let sceneView = arView?.sceneView else { return }
//            Logging.LogMe("... 1")
//
//            let newBall = SCNSphere(radius: 0.01)
//            let newBallNode = SCNNode(geometry: newBall)
//            newBallNode.position = hitPosition
//            sceneView.scene.rootNode.addChildNode(newBallNode)
//        }
//    }
//}
