//
//  ProcessingNodeDataGaussian.swift
//  Macintosh
//
//  Created by Sports Dad on 10/3/23.
//

import Foundation
import Vision
import CoreML
import Cocoa

class LearningNodeDataMobileNet: LearningNodeData {
    
    private static let MODEL_WIDTH = 224
    private static let MODEL_Height = 224
    
    
    var junq: Int = 8
    
    let dispatchGroup = DispatchGroup()
    
    override func process(rgbaImage: RGBImage, slice: MedicalSceneSlice) -> RGBImage {
        
        print("a mobile net is processing...")
        slice.tags.removeAll()
        if let cgImage = rgbaImage.cgImage(device: slice.graphics.device,
                                           graphics: slice.graphics) {
            if let resizedImage = CGImage.cropAndFit(image: cgImage, width: Self.MODEL_WIDTH, height: Self.MODEL_Height) {
                
                print("MobileNet => Ready To Go @ \(resizedImage.width) x \(resizedImage.height)")
                
                dispatchGroup.enter()
                
                classify(image: resizedImage)
                
                dispatchGroup.wait()
                print("never get here")
                
                if let s1 = classification1, let c1 = confidence1 {
                    slice.tags.append("\(s1) | \(c1)")
                }
                if let s2 = classification2, let c2 = confidence2 {
                    slice.tags.append("\(s2) | \(c2)")
                }
                if let s3 = classification3, let c3 = confidence3 {
                    slice.tags.append("\(s3) | \(c3)")
                }
                
                print("slice.tags = \(slice.tags)")
                
            } else {
                print("MobileNet => Could Not Resize")
            }
            
        } else {
            print("MobileNet => Could Not Have CGImage")
        }
        
        return rgbaImage.clone()
    }
    
    enum CodingKeys: String, CodingKey {
        case junq
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.junq = try container.decode(Int.self, forKey: .junq)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(junq, forKey: .junq)
    }
    
    @Published var classification1: String?
    @Published var confidence1: String?
    
    @Published var classification2: String?
    @Published var confidence2: String?
    
    @Published var classification3: String?
    @Published var confidence3: String?
    
    private lazy var model: MLModel? = {
        let configuration = MLModelConfiguration()
        do {
            let classifier = try MobileNet(configuration: configuration)
            return classifier.model
        } catch let error {
            print("MobileNet Model Load Error: \(error.localizedDescription)")
            return nil
        }
    }()
    
    private lazy var visionModel: VNCoreMLModel? = {
        guard let model = model else {
            return nil
        }
        do {
            let result = try VNCoreMLModel(for: model)
            return result
        } catch let error {
            print("VNCoreMLModel Load Error: \(error.localizedDescription)")
            return nil
        }
    }()
    
    /*
    func dragURLIntent(url: URL?) {
        guard let url = url else {
            failed(reason: "null url")
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    self.failed(reason: "data was not an image")
                    return
                }
                
                self.dragImageIntent(image: image)
                
            } catch let error {
                print("Data Download Error: \(error.localizedDescription)")
                self.failed(reason: "data download error")
            }
        }
    }
    */
    
    
    
    func classify(image: CGImage?) {
        
        
        guard let image = image else {
            failed(reason: "null image")
            dispatchGroup.leave()
            return
        }
        
        //guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)) else {
        //    failed(reason: "image orientation missing")
        //    return
        //}
        
        guard let visionModel = visionModel else {
            failed(reason: "vision model null")
            dispatchGroup.leave()
            return
        }
        
        let request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestHandler)
        let requests = [request]
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: image,
                                                        orientation: .up)
        
        do {
            try imageRequestHandler.perform(requests)
        } catch let error {
            print("Vision Image Request Error: \(error.localizedDescription)")
            failed(reason: "vision image request error")
            dispatchGroup.leave()
            return
        }
    }
    
    private func visionRequestHandler(request: VNRequest, error: Error?) {
        
        if let error = error {
            print("Vision Request Error: \(error.localizedDescription)")
            failed(reason: "vision request error")
            dispatchGroup.leave()
            return
        }
        
        guard let results = request.results else {
            failed(reason: "vision request missing results")
            dispatchGroup.leave()
            return
        }
        
        print("got \(results.count) results!!!")
        
        let classifications = results.compactMap {
            $0 as? VNClassificationObservation
        }
        
        guard classifications.count > 0 else {
            failed(reason: "no classifications found")
            dispatchGroup.leave()
            return
        }
        
        if classifications.count > 0 {
            self.classification1 = classifications[0].identifier
            self.confidence1 = self.string(percent: classifications[0].confidence)
        } else {
            self.classification1 = nil
            self.confidence1 = nil
        }
        
        if classifications.count > 1 {
            self.classification2 = classifications[1].identifier
            self.confidence2 = self.string(percent: classifications[1].confidence)
        } else {
            self.classification2 = nil
            self.confidence2 = nil
        }
        
        if classifications.count > 2 {
            self.classification3 = classifications[2].identifier
            self.confidence3 = self.string(percent: classifications[2].confidence)
        } else {
            self.classification3 = nil
            self.confidence3 = nil
        }
        
        print("classified \(classification1), \(classification2), \(classification3)")
        dispatchGroup.leave()
        
    }
    
    private func clearClassifications() {
        DispatchQueue.main.async {
            self.classification1 = nil
            self.confidence1 = nil
            
            self.classification2 = nil
            self.confidence2 = nil
            
            self.classification3 = nil
            self.confidence3 = nil
        }
    }
    
    func failed(reason: String) {
        print("Failed: \(reason)")
        clearClassifications()
        
    }
    
    private func string(percent: VNConfidence) -> String {
        let percent = max(min(percent * 100.0, 100.0), 0.0)
        return String(format: "%.1f%%", percent)
    }
    
}
