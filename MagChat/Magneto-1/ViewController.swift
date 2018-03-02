//
//  ViewController.swift
//  Magneto-1
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 Isaac Walerstein & Peter Woodsum. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let words1 = ["  could  ", "  cloud  ", "  bot  ", "  bit  ", "  ask  ", "  a  ", "  geek  ", "  flame  ", "  file  ", "  ed  ", "  ed  ", "  create  ", "  like  ", "  lap  ", "  is  ", "  ing  ", "  I  ", "  her  ", "  drive  ", "  get  ", "  soft  ", "  screen  ", "  protect  ", "  online  ", "  meme  ", "  to  ", "  they  ", "  that  ", "  tech  ", "  source  ", "  y  ", "  write  ", "  while  "]
    
    let words2 = ["  video  ", "  games  ", "  controller  ", "  online  ", "  offline  ", "  keyboard  ", "  mouse  ", "  character  ", "  world  ", "  enemy  ", "  ally  ", "  creature  ", "  fight  ", "  win  ", "  lose  ", "  victory  ", "  defeat  ", "  hero  ", "  villian  ", "  weapon  ", "  level  ", "  exp  ", "  sword  ", "  monster  "]
    
    let words3 = ["  fantasy  ", "  dragons  ", "  ogres  ", "  goblins  ", "  forests  ", "  castles  ", "  knights  ", "  horses  ", "  monsters  ", "  quests  ", "  noble  ", "  king  ", "  princess  ", "  quest  ", "  gold  ", "  adventure  ", "  slain  ", "  adventure  ", "  wizard  ", "  church  ", "  magic  ", "  feasts  ", "  loyalty  ", "  cities  ", "  townships  ",
                  "  thief  "]
    
    var workSpaceWords = [WordObject]()
    var wordBankWords = [WordObject]()
    var currentTheme = "Common"
    
    var backgroundImage:UIImage?
    
    @IBOutlet weak var wordBankOutlet: UIView!
    @IBOutlet weak var expandButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var wordBankHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var bankToolBar: UIToolbar!
    
    // Fill up -
    func recycleWords() {
        wordBankWords.removeAll()
        for subview in wordBankOutlet.subviews {
            if subview.tag == 100 {
                subview.removeFromSuperview()
            }
        }
        
        var firstInRow = true
        
        var x:CGFloat = 0.0
        var y:CGFloat = 50.0 + bankToolBar.frame.height

        var notFull = true

        while notFull {
            let word = randomWord()
            
            let tempLabel = UILabel()
            tempLabel.backgroundColor = UIColor.white
            tempLabel.text = word
            tempLabel.font = tempLabel.font.withSize(view.frame.height * 0.023); // Scale font based on the screen height
            tempLabel.sizeToFit()
            tempLabel.tag = 100
            if firstInRow {
                x = 30 + ( tempLabel.frame.width / 2 )
                firstInRow = false
            }
            else {
                x += 30 + ( tempLabel.frame.width / 2 )
            }
            tempLabel.center = CGPoint(x:x, y:y)
            tempLabel.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            tempLabel.addGestureRecognizer(panGesture)

            x += ( tempLabel.frame.width / 2 )

            wordBankOutlet.addSubview(tempLabel)
            
            wordBankWords.append(WordObject(xPosition: Float(tempLabel.center.x), yPosition: Float(tempLabel.center.y), wordText: tempLabel.text!))
            
            if x >= view.frame.size.width - 250 {
                firstInRow = true
                y += 50
                if y >= wordBankOutlet.frame.height - 25 {
                    notFull = false
                }
            }
        }
    }
    
    // Not currently being used
    func placeWords(words: [String]) {
        var firstInRow = true
        var x:CGFloat = 0.0
        var y:CGFloat = 50.0
        for word in words {
            let tempLabel = UILabel()
            tempLabel.backgroundColor = UIColor.white
            tempLabel.text = word
            tempLabel.font = tempLabel.font.withSize(view.frame.height * 0.023); // Scale font based on the screen height
            tempLabel.sizeToFit()
            if firstInRow {
                x = 30 + ( tempLabel.frame.width / 2 )
                firstInRow = false
            }
            else {
                x += 30 + ( tempLabel.frame.width / 2 )
            }
            tempLabel.center = CGPoint(x:x, y:y)
            tempLabel.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            tempLabel.addGestureRecognizer(panGesture)
            view.addSubview(tempLabel)
            if x >= view.frame.size.width - 150 {
                firstInRow = true
                y += 50
            }
            x += ( tempLabel.frame.width / 2 )
        }
    }
    
    // Returns a random word from the current themed word list
    func randomWord() -> String{
        var tempWord = ""
        if currentTheme == "Common" {
            let randomNumber = arc4random_uniform(_:UInt32(words1.count))
            tempWord = words1[Int(randomNumber)]
            
        }
        else if currentTheme == "Video Games" {
            let randomNumber = arc4random_uniform(_:UInt32(words2.count))
            tempWord = words2[Int(randomNumber)]
        }
        else if currentTheme == "Fantasy" {
            let randomNumber = arc4random_uniform(_:UInt32(words3.count))
            tempWord = words3[Int(randomNumber)]
        }
        
        return tempWord
    }
    
    // Now just clears the words from main view
    func clearScreen() {
        for subview in view.subviews {
            if subview.tag == 100 {
                subview.removeFromSuperview()
            }
        }
        
        //view.subviews.forEach({ $0.removeFromSuperview() })
        //ViewController().placeWords(words: words1)
        //print("CLICKED")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = UIColor.blue
        wordBankHeight.constant = view.frame.height / 4 + bankToolBar.frame.height
        recycleWords()
 
        //placeWords(words: words1)
    }
    
    // Updated to switch which view the label is part of depending on its location
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        var position = panGesture.location(in: view)
        if position.y > wordBankOutlet.frame.minY {
            wordBankOutlet.addSubview(label)
            position = panGesture.location(in: wordBankOutlet)
            label.center = position
        } else {
            view.addSubview(label)
            position = panGesture.location(in: view)
            label.center = position
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("finished picking")
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .center
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue"{
            let themesVC = segue.destination.childViewControllers[0] as! themeTableVC
            themesVC.themes = ["common", "common2", "common3"]
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        clearScreen()
    }
    
    // Button click action which expands or minimizes the word bank view
    @IBAction func expandButton(_ sender: Any) {
        view.layoutIfNeeded()
        if (wordBankOutlet.frame.minY == bottomToolBar.frame.minY - wordBankOutlet.frame.height) {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
                self.wordBankOutlet.center.y = self.bottomToolBar.frame.maxY + self.wordBankOutlet.frame.height / 2
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
                self.wordBankOutlet.center.y = self.bottomToolBar.frame.minY - self.wordBankOutlet.frame.height / 2
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    // Currently just used to set the theme variable to the selected theme
    @IBAction func unwindToMain(segue:UIStoryboardSegue) {
        if segue.identifier == "DoneTapped"{
            let themesVC = segue.source as! themeTableVC
            let theme = themesVC.selectedTheme
            currentTheme = theme
            recycleWords()
//            let end = self.view.subviews.count - 1
//            if end > 0 {
//                for _ in 1...end {
//                    self.view.subviews[1].removeFromSuperview()
//                }
//            }
//            if theme == "Common" {
//                self.placeWords(words: words1)
//            }
//            if theme == "Video Games" {
//                self.placeWords(words: words2)
//            }
//            if theme == "Fantasy" {
//                self.placeWords(words: words3)
//            }
        }
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        //if UIImagePickerController.isSourceTypeAvailable(.camera){
        //     imagePickerController.sourceType = .camera
        // }else{
        //      imagePickerController.sourceType = .savedPhotosAlbum
        // }
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: {})
    }
    
    // Refresh the word bank on button press
    @IBAction func refreshWordBank(_ sender: Any) {
        recycleWords()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

