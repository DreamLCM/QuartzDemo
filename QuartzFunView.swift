//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by MAC on 16/5/18.
//  Copyright © 2016年 MAC. All rights reserved.
//

import UIKit
/*
 创建随机颜色
 */
extension UIColor {
    
    class func randomColor() -> UIColor {
        let red = CGFloat(Double((arc4random() % 256)) / 255)
        let green = CGFloat(Double((arc4random() % 256)) / 255)
        let blue = CGFloat(Double((arc4random() % 256)) / 255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

/*
 定义形状和颜色的枚举
 */

// 可以绘制的形状
enum Shape : UInt {
    case Line = 0, Rect, Ellipse, Image
}

// 颜色枚举
enum DrawingColor : UInt {
    case Red = 0, Blue, Yellow, Green, Random
}


class QuartzFunView: UIView {

    // 进行绘制的视图
    var shape = Shape.Line
    var currentColor = UIColor.redColor()
    var useRandomColor = false
    
    // 内部私有属性
    private let image = UIImage(named: "2.jpg")
    private var firstTouchLocation:CGPoint = CGPointZero
    private var lastTouchLocation:CGPoint = CGPointZero
    private var redrawRect:CGRect = CGRectZero
    
    // 手指第一次触摸被调用
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        let touch = touches
        
        // Swift新的书写方式，获取第一次触摸的位置
        firstTouchLocation = (touch.first?.locationInView(self))!
        
        
        lastTouchLocation = firstTouchLocation
        redrawRect = CGRectZero
        setNeedsDisplay()
    }
    
    // 手指在屏幕拖动被调用
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches
        lastTouchLocation = (touch.first?.locationInView(self))!
//        setNeedsDisplay()
        
        if shape == .Image {
            let horizontalOffset = (image?.size.width)! / 2
            let verticalOffset = (image?.size.height)! / 2
            redrawRect = CGRectUnion(redrawRect, CGRectMake(lastTouchLocation.x - horizontalOffset, lastTouchLocation.y - verticalOffset, (image?.size.width)!, (image?.size.height)!))
        } else {
            
            // CGRectUnion 是可以覆盖两个参数矩形之间的最小矩形
            redrawRect  = CGRectUnion(redrawRect, currentRect())
            print(redrawRect)
        }
        setNeedsDisplayInRect(redrawRect)
    }
    
    // 手指离开屏幕被调用
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches
        lastTouchLocation = (touch.first?.locationInView(self))!
        setNeedsDisplay()
    }
    
    // 重写View
    override func drawRect(rect: CGRect) {
        // 获取当前环境
        let context = UIGraphicsGetCurrentContext()
        // 线的宽度
        CGContextSetLineWidth(context, 2.0)
        // 线的颜色
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
        // 矩形或者圆形填充颜色
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
        
        // 矩形或者圆形画的位置
//        let currentRect = CGRectMake(firstTouchLocation.x, firstTouchLocation.y, lastTouchLocation.x - firstTouchLocation.x, lastTouchLocation.y - firstTouchLocation.y)
        
        
        
        switch shape {
        case .Line:
            // 线的起点位置
            CGContextMoveToPoint(context, firstTouchLocation.x, firstTouchLocation.y)
//            print(firstTouchLocation.x , firstTouchLocation.y, lastTouchLocation.x, lastTouchLocation.y)
            // 线的终点位置
            CGContextAddLineToPoint(context, lastTouchLocation.x, lastTouchLocation.y)
            // 将线添加到当前的环境
            CGContextStrokePath(context)
            
        case .Rect:
            
            // 矩形的位置
            CGContextAddRect(context, currentRect())
            // 绘画并填充的函数
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            break
        case .Ellipse:
            // 圆形的位置
            CGContextAddEllipseInRect(context, currentRect())
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            break
        case .Image:
            //  1/2图片的宽度
            let horizontalOffset = (image?.size.width)! / 2
            //  1/2图片的高度
            let verticalOffset = (image?.size.height)! / 2
            //  图片的中心
            let drawPoint = CGPointMake(lastTouchLocation.x - horizontalOffset, lastTouchLocation.y - verticalOffset)
            image?.drawAtPoint(drawPoint)
//            print(drawPoint , lastTouchLocation.x ,horizontalOffset)
            break
        
        }
    }
    
    func currentRect() -> CGRect {
        return CGRectMake(firstTouchLocation.x, firstTouchLocation.y, lastTouchLocation.x - firstTouchLocation.x, lastTouchLocation.y - firstTouchLocation.y)
    }
    
}



