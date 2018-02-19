//
//  ViewController.swift
//  Magneto-1
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 IsaacWalerstein & Peter Woodsum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let words1 = ["  could  ", "  cloud  ", "  bot  ", "  bit  ", "  ask  ", "  a  ", "  geek  ", "  flame  ", "  file  ", "  ed  ", "  ed  ", "  create  ", "  like  ", "  lap  ", "  is  ", "  ing  ", "  I  ", "  her  ", "  drive  ", "  get  ", "  soft  ", "  screen  ", "  protect  ", "  online  ", "  meme  ", "  to  ", "  they  ", "  that  ", "  tech  ", "  source  ", "  y  ", "  write  ", "  while  "]
    let words2 = ["  video  ", "  games  ", "  controller  ", "  online  ", "  offline  ", "  keyboard  ", "  mouse  ", "  character  ", "  world  ", "  enemy  ", "  ally  ", "  creature  ", "  fight  ", "  win  ", "  lose  ", "  victory  ", "  defeat  ", "  hero  ", "  villian  ", "  weapon  ", "  level  ", "  exp  ", "  sword  ", "  monster  "]
    let words3 = ["  fantasy  ", "  dragons  ", "  ogres  ", "  goblins  ", "  forests  ", "  castles  ", "  knights  ", "  horses  ", "  monsters  ", "  quests  ", "  noble  ", "  king  ", "  princess  ", "  quest  ", "  gold  ", "  adventure  ", "  slain  ", "  adventure  ", "  wizard  ", "  church  ", "  magic  ", "  feasts  ", "  loyalty  ", "  cities  ", "  townships  ",
                  "  thief  "]
    
    func placeWords(words: [String]){
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
            if x >= view.frame.size.width - 150{
                firstInRow = true
                y += 50
            }
            x += (l.frame.width/2)
        }
    }
    
    func clearScreen(){
        view.subviews.forEach({ $0.removeFromSuperview() })
        ViewController().placeWords(words: words1)
        print("CLICKED")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        super.view.backgroundColor = UIColor.orange
    }
    
    
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer){
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue"{
            let themesVC = segue.destination.childViewControllers[0] as! themeTableVC
            themesVC.themes = ["common", "common2", "common3"]
        }
    }
    @IBAction func unwindToMain(segue:UIStoryboardSegue){
        if segue.identifier == "DoneTapped"{
            let themesVC = segue.source as! themeTableVC
            let theme = themesVC.selectedTheme
            let end = self.view.subviews.count-1
            if end > 0{
                for _ in 1...end{
                    self.view.subviews[1].removeFromSuperview()
                }
            }
            if theme == "Common"{
                
                self.placeWords(words: words1)
            }
            if theme == "Video Games"{
                self.placeWords(words: words2)
            }
            if theme == "Fantasy"{
                self.placeWords(words: words3)
                }
                
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

