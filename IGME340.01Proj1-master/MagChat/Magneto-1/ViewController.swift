//
//  ViewController.swift
//  Magneto-1
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 IsaacWalerstein & Peter Woodsum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let words = ["  could  ", "  cloud  ", "  bot  ", "  bit  ", "  ask  ", "  a  ", "  geek  ", "  flame  ", "  file  ", "  ed  ", "  ed  ", "  create  ", "  like  ", "  lap  ", "  is  ", "  ing  ", "  I  ", "  her  ", "  drive  ", "  get  ", "  soft  ", "  screen  ", "  protect  ", "  online  ", "  meme  ", "  to  ", "  they  ", "  that  ", "  tech  ", "  source  ", "  y  ", "  write  ", "  while  "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placeWords()
    }
    
    func placeWords(){
        view.backgroundColor = UIColor.orange
        var firstInRow = true
        var x:CGFloat = 0.0
        var y:CGFloat = 50.0
        for word in words{
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = word
            l.sizeToFit()
            if firstInRow{
                x = 30 + (l.frame.width/2)
                firstInRow = false
            }
            else{
                x += 30 + (l.frame.width/2)
            }
            
            l.center = CGPoint(x:x, y:y)
            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
            view.addSubview(l)
            if x >= view.frame.size.width - 120{
                firstInRow = true
                y += 50
            }
            x += (l.frame.width/2)
        }
    }
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer){
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }
}

