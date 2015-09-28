

import UIKit

class CircleGraphView: UIView {
    
    var endArc:CGFloat = 0.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    var arcWidth:CGFloat = 10.0
    var arcColor = UIColor.yellowColor()
    var arcBackgroundColor = UIColor.blackColor()

    override func drawRect(rect: CGRect) {
        let fullCircle = 2.0 * CGFloat(M_PI)
        let start: CGFloat = -0.25 * fullCircle
        let end: CGFloat = endArc * fullCircle + start
        
        let centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        var radius:CGFloat = 0.0
        if CGRectGetWidth(rect) > CGRectGetHeight(rect){
            radius = (CGRectGetWidth(rect) - arcWidth) / 2.0
        }else{
            radius = (CGRectGetHeight(rect) - arcWidth) / 2.0
        }
        
        let context = UIGraphicsGetCurrentContext()
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        CGContextSetLineWidth(context, arcWidth)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetStrokeColorWithColor(context, arcColor.CGColor)
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, start, end, 0)
        CGContextStrokePath(context)
    }

}
