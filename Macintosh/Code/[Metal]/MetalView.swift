//
//  MetalView.swift
//  BloodRobotDoctor
//
//  Created by Sports Dad on 2/9/23.
//

#if os(macOS)
import Cocoa

class MetalView: NSView {
    
    let delegate: GraphicsDelegate
    let graphics: Graphics
    
    //private var timer: CADisplayLink?
    var displayLink: CVDisplayLink?
    
    required init(delegate: GraphicsDelegate,
                  graphics: Graphics,
                  width: CGFloat,
                  height: CGFloat) {
        self.delegate = delegate
        self.graphics = graphics
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        
        self.wantsLayer = true
        self.layer = CAMetalLayer()
        //self.layer?.drawsAsynchronously = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var engine: MetalEngine = {
        MetalEngine(delegate: delegate, graphics: graphics, layer: layer as! CAMetalLayer)
    }()
    
    lazy var pipeline: MetalPipeline = {
        MetalPipeline(engine: engine)
    }()
    
    /*
    override class var layerClass: AnyClass {
        return CAMetalLayer.self
    }
    */
    
    func load() {
        
        delegate.initialize(graphics: graphics)
        
        engine.load()
        pipeline.load()
        
        delegate.load()
        
        

        var successLink = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
                
        if let timer = displayLink
        {
            
            successLink = CVDisplayLinkSetOutputCallback(timer,
                                                         {
                                                            (timer : CVDisplayLink, currentTime : UnsafePointer<CVTimeStamp>, outputTime : UnsafePointer<CVTimeStamp>, _ : CVOptionFlags, _ : UnsafeMutablePointer<CVOptionFlags>, sourceUnsafeRaw : UnsafeMutableRawPointer?) -> CVReturn in
                unsafeBitCast(sourceUnsafeRaw, to: MetalView.self).drawloop()
                return kCVReturnSuccess
                                                            
            }, Unmanaged.passUnretained(self).toOpaque())
            
            guard successLink == kCVReturnSuccess else
            {
                print("Failed to create timer with active display")
                
                return
            }
            
            successLink = CVDisplayLinkSetCurrentCGDisplay(timer, CGMainDisplayID())
            
            guard successLink == kCVReturnSuccess else
            {
                print("dl error")
                return
            }
            
            self.displayLink = timer
            
            CVDisplayLinkStart(timer)
        }
        
        /*
        CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        if let displayLink = displayLink {
            CVDisplayLinkSetOutputCallback(displayLink, displayLinkOutputCallback, nil)
            
            //CVDisplayLinkSetOutputCallback(displayLink, displayLinkOutputCallback, UnsafeMutablePointer<Void>(unsafeAddressOf(self)))
            CVDisplayLinkStart(displayLink)
        }
        */
        
        /*
        
        timer?.invalidate()
         
         
        timer = CADisplayLink(target: self, selector: #selector(drawloop))
        if let timer = timer {
            timer.add(to: RunLoop.main, forMode: .default)
        }
        */
    }
    
    /*
    func displayLinkOutputCallback(displayLink: CVDisplayLink, _ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>, _ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>, _ displayLinkContext: UnsafeMutableRawPointer) -> CVReturn {

        /*  The displayLinkContext is CVDisplayLink's parameter definition of the view in which we are working.
            In order to access the methods of a given view we need to specify what kind of view it is as right
            now the UnsafeMutablePointer<Void> just means we have a pointer to "something".  To cast the pointer
            such that the compiler at runtime can access the methods associated with our SwiftOpenGLView, we use
            an unsafeBitCast.  The definition of which states, "Returns the the bits of x, interpreted as having
            type U."  We may then call any of that view's methods.  Here we call drawView() which we draw a
            frame for rendering.  */
        //unsafeBitCast(displayLinkContext, SwiftOpenGLView.self).renderFrame()
        drawloop()

        //  We are going to assume that everything went well for this mock up, and pass success as the CVReturn
        return kCVReturnSuccess
    }
    */
    
    func drawloop() {
        delegate.update()
        engine.draw()
    }
    
    deinit {
        //When the view gets destroyed, we don't want to keep the link going.
        if let displayLink = displayLink {
            CVDisplayLinkStop(displayLink)
            self.displayLink = nil
        }
    }
    
}


#else

import UIKit

class MetalView: UIView {
    
    let delegate: GraphicsDelegate
    let graphics: Graphics
    
    private var timer: CADisplayLink?
    
    required init(delegate: GraphicsDelegate,
                  graphics: Graphics,
                  width: CGFloat,
                  height: CGFloat) {
        self.delegate = delegate
        self.graphics = graphics
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var engine: MetalEngine = {
        MetalEngine(delegate: delegate, graphics: graphics, layer: layer as! CAMetalLayer)
    }()
    
    lazy var pipeline: MetalPipeline = {
        MetalPipeline(engine: engine)
    }()
    
    override class var layerClass: AnyClass {
        return CAMetalLayer.self
    }
    
    func load() {
        
        delegate.initialize(graphics: graphics)
        
        engine.load()
        pipeline.load()
        
        delegate.load()
        
        timer?.invalidate()
        timer = CADisplayLink(target: self, selector: #selector(drawloop))
        if let timer = timer {
            timer.add(to: RunLoop.main, forMode: .default)
        }
    }
    
    @objc func drawloop() {
        delegate.update()
        engine.draw()
    }
    
}

#endif
