//
//  ViewController.swift
//  ErdoGame
//
//  Created by Erdo on 31.12.2018.
//  Copyright © 2018 Erdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var erdo1: UIImageView!
    @IBOutlet weak var erdo2: UIImageView!
    @IBOutlet weak var erdo3: UIImageView!
    @IBOutlet weak var erdo4: UIImageView!
    @IBOutlet weak var erdo5: UIImageView!
    @IBOutlet weak var erdo6: UIImageView!
    @IBOutlet weak var erdo7: UIImageView!
    @IBOutlet weak var erdo8: UIImageView!
    @IBOutlet weak var erdo9: UIImageView!
    
    var score = 0
    var counter = 0
    var erdoArray = [UIImageView]()
    var timer = Timer()
    var hideTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        if highScore == nil{
            highScoreLabel.text = "0"
        }
        if let newScore = highScore as? Int{
            highScoreLabel.text = "\(newScore)"
        }
        
        
        
        scoreLabel.text="Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))

        erdo1.isUserInteractionEnabled=true //tıklanma olsun diyoruz
        erdo2.isUserInteractionEnabled=true
        erdo3.isUserInteractionEnabled=true
        erdo4.isUserInteractionEnabled=true
        erdo5.isUserInteractionEnabled=true
        erdo6.isUserInteractionEnabled=true
        erdo7.isUserInteractionEnabled=true
        erdo8.isUserInteractionEnabled=true
        erdo9.isUserInteractionEnabled=true
        
        erdo1.addGestureRecognizer(recognizer1) //her resme tıklanma özelliği verdik.
        erdo2.addGestureRecognizer(recognizer2)
        erdo3.addGestureRecognizer(recognizer3)
        erdo4.addGestureRecognizer(recognizer4)
        erdo5.addGestureRecognizer(recognizer5)
        erdo6.addGestureRecognizer(recognizer6)
        erdo7.addGestureRecognizer(recognizer7)
        erdo8.addGestureRecognizer(recognizer8)
        erdo9.addGestureRecognizer(recognizer9)
        //erdoyu ekle araye
        erdoArray.append(erdo1)
        erdoArray.append(erdo2)
        erdoArray.append(erdo3)
        erdoArray.append(erdo4)
        erdoArray.append(erdo5)
        erdoArray.append(erdo6)
        erdoArray.append(erdo7)
        erdoArray.append(erdo8)
        erdoArray.append(erdo9)
        //random getir
        
        counter = 5
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideErdo), userInfo: nil, repeats: true)
        
        
    }
    @objc func hideErdo (){
        for erdogan in erdoArray{
            erdogan.isHidden = true //hepsini sakla
        }
        let random = Int(arc4random_uniform(UInt32(erdoArray.count)))  //0 ile 8 arası sayı üretiyor
        erdoArray[random].isHidden = false //random göster
    
    }
    @objc func countDown(){
        counter = counter - 1
        timeLabel.text = "\(counter)"
        if counter==0{
            timer.invalidate()
            hideTimer.invalidate()
            if self.score > Int(highScoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highscore")
                self.highScoreLabel.text="\(self.score)"
            }
            let alert = UIAlertController(title: "Zaman", message: "Zaman Doldu", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Yüksek scoru Sil", style: UIAlertAction.Style.default) {(UIAlertAction) in
                UserDefaults.standard.removeObject(forKey: "highscore")
                self.counter = 5
                self.score = 0
                self.timeLabel.text = "\(self.counter)"
                self.scoreLabel.text = "Score: \(self.score)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideErdo), userInfo: nil, repeats: true)
            }
            let replayButton = UIAlertAction(title: "Replay", style:UIAlertAction.Style.default) { (UIAlertAction) in
                self.counter = 5
                self.score = 0
                self.timeLabel.text = "\(self.counter)"
                self.scoreLabel.text = "Score: \(self.score)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideErdo), userInfo: nil, repeats: true)
            }

            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    @objc func increaseScore(){
        score = score + 1
        scoreLabel.text="Score: \(score)"
        
    }

}

