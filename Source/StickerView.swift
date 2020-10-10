//
//  StickerView.swift
//  StickerView
//
//  Created by sachitha on 9/19/20.
//

import Foundation

/// Delegates
@objc protocol StickerViewDelegate {
    @objc func stickerViewDidRemove(_ view:StickerView)
    @objc func stickerViewDidBeginScale(_ view:StickerView)
    @objc func stickerViewDidChangeScale(_ view:StickerView)
    @objc func stickerViewDidBeginRotating(_ stickerView: StickerView)
    @objc func stickerViewDidChangeRotating(_ stickerView: StickerView)
    @objc func stickerViewDidEndRotating(_ stickerView: StickerView)
    @objc func stickerViewDidBeginMoving(_ stickerView: StickerView)
    @objc func stickerViewDidChangeMoving(_ stickerView: StickerView)
    @objc func stickerViewDidEndMoving(_ stickerView: StickerView)
}


@inline(__always) func CGRectGetCenter(_ rect:CGRect) -> CGPoint {
    return CGPoint(x: rect.midX, y: rect.midY)
}

@inline(__always) func CGPointGetDistance(point1:CGPoint, point2:CGPoint) -> CGFloat {
    let fx = point2.x - point1.x
    let fy = point2.y - point1.y
    return sqrt(fx * fx + fy * fy)
}
@inline(__always) func CGRectScale(_ rect:CGRect, wScale:CGFloat, hScale:CGFloat) -> CGRect {
    return CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * wScale, height: rect.size.height * hScale)
}

@inline(__always) func CGAffineTransformGetAngle(_ t:CGAffineTransform) -> CGFloat {
    return atan2(t.b, t.a)
}

open class StickerView:UIView{
    //gestures
    private lazy var removeGesture = {
        return UITapGestureRecognizer(target: self, action: #selector(removeGesture(_:)))
    }()
    private lazy var scaleGesture = {
        return UIPanGestureRecognizer(target: self, action: #selector(scaleGesture(_:)))
    }()
    
    private lazy var scaleFingureGesture = {
        return UIPinchGestureRecognizer(target: self, action: #selector(scaleFingureGesture(_:)))
    }()
    
    private lazy var rotateGesture = {
        return UIPanGestureRecognizer(target: self, action: #selector(rotateGesture(_:)))
    }()
    
    private lazy var rotateFingureGesture = {
        return UIRotationGestureRecognizer(target: self, action: #selector(rotateFingureGesture(_:)))
    }()
    private lazy var stretchWidthGesture = {
        return UIPanGestureRecognizer(target: self, action: #selector(stretchWidthGesture(_:)))
    }()
    
    private lazy var stretchHeightGesture = {
        return UIPanGestureRecognizer(target: self, action: #selector(stretchHeightGesture(_:)))
    }()
    
    private lazy var movFingureGesture = {
        return UIPanGestureRecognizer(target: self, action: #selector(movFingureGesture(_:)))
    }()
    
    
    var delegate: StickerViewDelegate!
    private var configuration: Configuration!
    var contentView:UIView!
    var boundaryView:UIView!
    
    /**
        *  Variables for rotating and resizing view
        */
       private var initialBounds = CGRect.zero
       private var initialDistance:CGFloat = 0
       private var deltaAngle:CGFloat = 0
    /**
         *  Variables for moving view
         */
        private var beginningPoint = CGPoint.zero
        private var beginningCenter = CGPoint.zero
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(contentView: UIView,configuration:Configuration) {
        //super view
        let frame = contentView.frame
        super.init(frame: frame)
        boundaryView = UIView()
        
        self.addGestureRecognizer(scaleFingureGesture)
        self.addGestureRecognizer(rotateFingureGesture)
        self.addGestureRecognizer(movFingureGesture)
        // Setup content view
        self.contentView = contentView
        self.contentView.center = CGRectGetCenter(self.bounds)
        self.contentView.isUserInteractionEnabled = false
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.layer.allowsEdgeAntialiasing = true
        self.addSubview(self.contentView)
        
        
        //configuration bounding view
        self.setConfiguration(configuration: configuration)
    }
    

}
//MARK: - Configuration Set Gestures
extension StickerView{
    @objc func removeGesture(_ recognizer: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            delegate.stickerViewDidRemove(self)
        }
        self.removeFromSuperview()
    }
    @objc func scaleGesture(_ recognizer: UITapGestureRecognizer) {
        let touchLocation = recognizer.location(in: self.superview)
        let center = self.center
        
        switch recognizer.state {
        case .began:
            self.initialBounds = self.bounds
            self.initialDistance = CGPointGetDistance(point1: center, point2: touchLocation)
            if let delegate = self.delegate {
                delegate.stickerViewDidBeginScale(self)
            }
        break
        case .possible:
        break
        case .changed:
            var scale = CGPointGetDistance(point1: center, point2: touchLocation) / self.initialDistance
            let minimumScale = self.configuration.minimumSize / min(self.initialBounds.size.width, self.initialBounds.size.height)
            scale = max(scale, minimumScale)
            let scaledBounds = CGRectScale(self.initialBounds, wScale: scale, hScale: scale)
            self.bounds = scaledBounds
            self.setNeedsDisplay()
            
            if let delegate = self.delegate {
                delegate.stickerViewDidChangeScale(self)
            }
        break
        case .ended:
        break
        case .cancelled:
        break
        case .failed:
        break
        }
    }
    //scretch
    @objc func stretchWidthGesture(_ recognizer: UITapGestureRecognizer) {
        let touchLocation = recognizer.location(in: self.superview)
        let center = self.center
        
        switch recognizer.state {
        case .began:
            self.initialBounds = self.bounds
            self.initialDistance = CGPointGetDistance(point1: center, point2: touchLocation)
            if let delegate = self.delegate {
                delegate.stickerViewDidBeginScale(self)
            }
        break
        case .possible:
        break
        case .changed:
            var scale = CGPointGetDistance(point1: center, point2: touchLocation) / self.initialDistance
            let minimumScale = self.configuration.minimumSize / min(self.initialBounds.size.width, self.initialBounds.size.height)
            scale = max(scale, minimumScale)
            let scaledBounds = CGRectScale(self.initialBounds, wScale: scale, hScale: 1)
            self.bounds = scaledBounds
            self.setNeedsDisplay()
            
            if let delegate = self.delegate {
                delegate.stickerViewDidChangeScale(self)
            }
        break
        case .ended:
        break
        case .cancelled:
        break
        case .failed:
        break
        }
    }
    
    @objc func stretchHeightGesture(_ recognizer: UITapGestureRecognizer) {
        let touchLocation = recognizer.location(in: self.superview)
        let center = self.center
        
        switch recognizer.state {
        case .began:
            self.initialBounds = self.bounds
            self.initialDistance = CGPointGetDistance(point1: center, point2: touchLocation)
            if let delegate = self.delegate {
                delegate.stickerViewDidBeginScale(self)
            }
        break
        case .possible:
        break
        case .changed:
            var scale = CGPointGetDistance(point1: center, point2: touchLocation) / self.initialDistance
            let minimumScale = self.configuration.minimumSize / min(self.initialBounds.size.width, self.initialBounds.size.height)
            scale = max(scale, minimumScale)
            let scaledBounds = CGRectScale(self.initialBounds, wScale: 1, hScale: scale)
            self.bounds = scaledBounds
            self.setNeedsDisplay()
            
            if let delegate = self.delegate {
                delegate.stickerViewDidChangeScale(self)
            }
        break
        case .ended:
        break
        case .cancelled:
        break
        case .failed:
        break
        }
    }
    
    @objc func scaleFingureGesture(_ recognizer: UIPinchGestureRecognizer) {
            let touchLocation = recognizer.location(in: self.superview)
        let center = self.center
        
        switch recognizer.state {
        case .began:
            self.initialBounds = self.bounds
            self.initialDistance = CGPointGetDistance(point1: center, point2: touchLocation)
            if let delegate = self.delegate {
                delegate.stickerViewDidBeginScale(self)
            }
        break
        case .possible:
        break
        case .changed:
            var scale = recognizer.scale 
            let minimumScale = self.configuration.minimumSize / min(self.initialBounds.size.width, self.initialBounds.size.height)
            scale = max(scale, minimumScale)
            let scaledBounds = CGRectScale(self.initialBounds, wScale: scale, hScale: scale)
            self.bounds = scaledBounds
            self.setNeedsDisplay()
            
            if let delegate = self.delegate {
                delegate.stickerViewDidChangeScale(self)
            }
        break
        case .ended:
        break
        case .cancelled:
        break
        case .failed:
        break
        }
    }
    @objc func rotateGesture(_ recognizer: UITapGestureRecognizer) {
        let touchLocation = recognizer.location(in: self.superview)
        let center = self.center
        
        switch recognizer.state {
        case .began:
            self.deltaAngle = CGFloat(atan2f(Float(touchLocation.y - center.y), Float(touchLocation.x - center.x))) - CGAffineTransformGetAngle(self.transform)
            self.initialBounds = self.bounds
            self.initialDistance = CGPointGetDistance(point1: center, point2: touchLocation)
            if let delegate = self.delegate {
                delegate.stickerViewDidBeginRotating(self)
            }
        case .changed:
            let angle = atan2f(Float(touchLocation.y - center.y), Float(touchLocation.x - center.x))
            let angleDiff = Float(self.deltaAngle) - angle
            self.transform = CGAffineTransform(rotationAngle: CGFloat(-angleDiff))
            
            self.setNeedsDisplay()
            
            if let delegate = self.delegate {
                delegate.stickerViewDidChangeRotating(self)
            }
        case .ended:
            if let delegate = self.delegate {
                delegate.stickerViewDidEndRotating(self)
            }
        default:
            break
        }
    }
    @objc func rotateFingureGesture(_ recognizer: UIRotationGestureRecognizer) {
        self.transform = self.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }
    @objc func movFingureGesture(_ recognizer: UIPanGestureRecognizer) {
            let touchLocation = recognizer.location(in: self.superview)
            switch recognizer.state {
            case .began:
                self.beginningPoint = touchLocation
                self.beginningCenter = self.center
                if let delegate = self.delegate {
                    delegate.stickerViewDidBeginMoving(self)
                }
            case .changed:
                self.center = CGPoint(x: self.beginningCenter.x + (touchLocation.x - self.beginningPoint.x), y: self.beginningCenter.y + (touchLocation.y - self.beginningPoint.y))
                if let delegate = self.delegate {
                    delegate.stickerViewDidChangeMoving(self)
                }
            case .ended:
                self.center = CGPoint(x: self.beginningCenter.x + (touchLocation.x - self.beginningPoint.x), y: self.beginningCenter.y + (touchLocation.y - self.beginningPoint.y))
                if let delegate = self.delegate {
                    delegate.stickerViewDidEndMoving(self)
                }
            default:
                break
            }
        }
}
//MARK: - Configuration Set Functions
extension StickerView{
    private func setConfiguration(configuration:Configuration){
        self.configuration = configuration
        self.setupFrame(insetMarging: configuration.insetMarging,
                        borderWidth: configuration.borderWidth,
                        borderColor: configuration.boarderColor)
        self.setupButtons(buttons: configuration.activeButtons)
    }
    
    private func setupFrame(insetMarging:CGFloat,borderWidth:CGFloat,borderColor:UIColor){
        var frame = self.contentView.frame
        
        let originalCenter = self.center
        let originalTransform = self.transform
        
        frame = CGRect(x: 0, y: 0, width: frame.size.width + insetMarging * 2, height: frame.size.height + insetMarging * 2)
//        self.frame = CGRect(x: 0, y: 0, width: frame.size.width + (configuration.buttonSize.width), height: frame.size.height + (configuration.buttonSize.height))
        self.contentView.removeFromSuperview()
        // bounding
        self.boundaryView.layer.borderColor = borderColor.cgColor
        self.boundaryView.layer.borderWidth = borderWidth
        self.boundaryView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.transform = CGAffineTransform.identity
        self.boundaryView.frame = frame
        self.frame = CGRect(x: 0, y: 0, width: frame.size.width + (configuration.buttonSize.width), height: frame.size.height + (configuration.buttonSize.height))
        
        
        self.contentView.center = CGRectGetCenter(self.bounds)
        self.boundaryView.center = CGRectGetCenter(self.bounds)
        self.addSubview(self.boundaryView)
        self.addSubview(self.contentView)
        self.sendSubview(toBack: self.contentView)
        
        self.center = originalCenter
        self.transform = originalTransform
    }
    
    private func setupButtons(buttons:[Button]){
        for button in buttons{
            setButtonOnPosition(button: button)
        }
    }
    
    private func setButtonOnPosition(button:Button){
        let origin = self.boundaryView.frame.origin
        let size = self.boundaryView.frame.size
        
        let handlerView:UIImageView? = UIImageView()
        handlerView?.image = button.image
        handlerView?.frame.size = button.buttonSize
        handlerView?.tintColor = button.tintColor
        handlerView?.isUserInteractionEnabled = true
        handlerView?.backgroundColor = .white
        
        switch button.buttonPosition {

        case .bottom_right:
            handlerView?.center = CGPoint(x: origin.x + size.width, y: origin.y + size.height)
            handlerView?.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
            break
        case .top_left:
            handlerView?.center = origin
            handlerView?.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
            
            break
        case .bottom_left:
            
             handlerView?.center = CGPoint(x: origin.x, y: origin.y + size.height)
             handlerView?.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin]
            
            break
        case .midle_left:
            handlerView?.center = CGPoint(x: origin.x + size.width, y: origin.y + size.height/2)
            handlerView?.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin,.flexibleBottomMargin]
                break
        case .midle_bottom:
            handlerView?.center = CGPoint(x: origin.x + size.width/2, y: origin.y + size.height)
            handlerView?.autoresizingMask = [.flexibleTopMargin,.flexibleLeftMargin,.flexibleRightMargin,.flexibleBottomMargin]
                break
        case .none:
            return


        }
        
        switch button.buttonType {
        case .remove:
            handlerView?.addGestureRecognizer(removeGesture)
            break
        case .scale:
            handlerView?.addGestureRecognizer(scaleGesture)
            break
        case .rotate:
            handlerView?.addGestureRecognizer(rotateGesture)
            break
        case .stretch_width:
            handlerView?.addGestureRecognizer(stretchWidthGesture)
        case .stretch_height:
            handlerView?.addGestureRecognizer(stretchHeightGesture)
        default :
            
            break
        }
        
        self.addSubview(handlerView!)
        self.bringSubview(toFront:handlerView! )
    }
}
