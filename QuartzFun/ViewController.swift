//
//  ViewController.swift
//  QuartzFun
//
//  Created by MAC on 16/5/18.
//  Copyright © 2016年 MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
     * 改变颜色
     */
    @IBAction func changeColor(sender: AnyObject) {
        
        let drawingColorSelection = DrawingColor(rawValue: UInt(sender.selectedSegmentIndex))
        
        if let drawingColor = drawingColorSelection {
            let funView = view as! QuartzFunView
            switch drawingColor {
            case .Red:
                funView.currentColor = UIColor.redColor()
                funView.useRandomColor = false
            case .Blue:
                funView.currentColor = UIColor.blueColor()
                funView.useRandomColor = false
            case .Yellow:
                funView.currentColor = UIColor.yellowColor()
                funView.useRandomColor = false
            case .Green:
                funView.currentColor = UIColor.greenColor()
                funView.useRandomColor = false
            case .Random:
                funView.useRandomColor = true
            
            }
        }
        
    }
    
    
    /*
     * 改变形状
     */
    @IBAction func changeShape(sender: AnyObject) {
        let shapeSelection = Shape(rawValue: UInt(sender.selectedSegmentIndex))
        if  let shape = shapeSelection {
            let funView = view as! QuartzFunView
            funView.shape = shape
            colorControl.hidden = shape == Shape.Image
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

