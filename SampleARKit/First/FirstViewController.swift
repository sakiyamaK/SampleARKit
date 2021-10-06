//
//  ViewController.swift
//  SampleARKit
//
//  Created by sakiyamaK on 2020/10/03.
//

import UIKit
import ARKit

final class FirstViewController: UIViewController {
    
    private let configuration = ARWorldTrackingConfiguration()
    private let imageTrackingConfiguration = ARImageTrackingConfiguration()
    
    private lazy var cubeNode = makeCube()
    private lazy var planeNode = makePlane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        imageTrackingConfiguration.trackingImages = [ARReferenceImage.init(UIImage(named: "ArtSticker")!.cgImage!, orientation: .up, physicalWidth: 0.05)]
//        sceneView.session.run(imageTrackingConfiguration)
        
//            configuration.planeDetection = .vertical
//            sceneView.session.run(configuration)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeView()
    }
}

private extension FirstViewController {

    func makeView() {
        guard let scene = SCNScene(named: "dragon.scn") else {
            print("slime.scn not found")
            return
        }
        let sceneView: ARSCNView = .init()
        self.view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        //制約をつける
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: self.view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor)
        ])
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.scene = scene
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    func makePlane() ->SCNNode {
        let plane = SCNPlane(width: 0.10, height: 0.10)
        let planeNode = SCNNode(geometry: plane)
        
        let m1 = SCNMaterial()
        m1.diffuse.contents = UIImage(named: "shizue")
        plane.materials = [m1]
        
        //    planeNode.position = SCNVector3(0, 0, 0)
        return planeNode
    }
    
    func makeCube() -> SCNNode {
        // 幅10cm、高さ20cm、奥行き30cmの立方体を作成
        
        let cube = SCNBox(width: 0.2, height: 0.2, length: 0, chamferRadius: 0)
        let cubeNode = SCNNode(geometry: cube)
        
        // 6面、別々のテクスチャを貼る
        let m1 = SCNMaterial()
        let m2 = SCNMaterial()
        let m3 = SCNMaterial()
        let m4 = SCNMaterial()
        let m5 = SCNMaterial()
        let m6 = SCNMaterial()
        
        m1.diffuse.contents = UIImage(named: "shizue")
        m2.diffuse.contents = UIImage(named: "shizue")
        m3.diffuse.contents = UIImage(named: "shizue")
        m4.diffuse.contents = UIImage(named: "shizue")
        m5.diffuse.contents = UIImage(named: "shizue")
        m6.diffuse.contents = UIImage(named: "shizue")
        
        cube.materials = [m1, m2, m3, m4, m5, m6]
        
        // 初期位置の指定: 50cm画面奥、10cm上方に配置
        cubeNode.position = SCNVector3Make(0, 0.1, -0.5)
        return cubeNode
    }
}

extension FirstViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("anchor:\(anchor), node: \(node), node geometry: \(String(describing: node.geometry))")
        // 平面ジオメトリを持つノードをx軸まわりに90度回転
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1, 0, 0)
        DispatchQueue.main.async(execute: {
            // 仮想オブジェクトを乗せる
            node.addChildNode(self.planeNode)
        })
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        print("\(self.classForCoder): " + #function)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        print("\(self.classForCoder): " + #function)
    }
    
}

extension FirstViewController: ARSessionDelegate {
    
}
