//
//  ViewController.swift
//  CatchPichu
//
//  Created by Penny Huang on 2020/3/21.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit
import AVFoundation

class GameVC: UIViewController {

    
    @IBOutlet var pokemonButtonOutlet: [UIButton]!
    
    @IBOutlet weak var gameTimeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    let pichuArray = Array(repeating: "pichu", count: 6)
    let pikachuArray = Array(repeating: "pikachu", count: 2)
    let raichuArray = Array(repeating: "raichu", count: 1)
    var gameTime = 10
    var totalScroe = 0
    
    let player = AVPlayer()
    
    
    @IBAction func StartButtonPressed(_ sender: UIButton) {
        playMusic()
        gameStart()
        sender.isHidden = true
    }
    
    
    @IBAction func pokemonButtonPressed(_ sender: UIButton) {
        
        let pokemonHit = pokemonButtonOutlet[sender.tag - 1]
        
        if pokemonHit.currentImage != nil {

            // Set the score
            switch pokemonHit.titleLabel?.text {
            case "pikachu":
                totalScroe += 3
            case "raichu":
                totalScroe += 5
            default:
                totalScroe += 1
            }
            
            scoreLabel.text = "\(totalScroe)"
            
            // Let the image and title disappear after hit
            pokemonHit.setImage(nil, for: .normal)
            pokemonHit.setTitle(nil, for: .normal)
            
        }
        

    }
    
    func playMusic(){
        let fileUrl = Bundle.main.url(forResource: "BackgroundMusic", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
    }
    
    
    
    //使用者start遊戲後的動作，每1.5秒show pokemon
    func gameStart() {
        
        // Timer: game countdown
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.gameTime -= 1
            self.gameTimeLabel.text = String(self.gameTime)
            if self.gameTime == 0 {
                timer.invalidate()
                print("time's up")
                self.showTimesUpAlert()
                self.player.pause()
            }
        }
        
        // Timer: showing pokemon until time's up
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { (timer) in
            self.showPokemon()
            if self.gameTime == 0 {
                timer.invalidate()
                
                //all pokemon disappear when time's up
                for i in 0..<self.pokemonButtonOutlet.count {
                    self.pokemonButtonOutlet[i].setImage(nil, for: .normal)
                    self.pokemonButtonOutlet[i].isEnabled = false
                }
                
                print("stop showing pokemon. Your total score is \(self.totalScroe)")
            }
            
        }
    }
    
    //顯示pokemon的圖片
    @objc func showPokemon(){
        
        //button: 找出所有空的button
        var emptyButtonArray = [UIButton]()
        for i in 1...pokemonButtonOutlet.count {
            if pokemonButtonOutlet[i - 1].currentImage == nil {
                emptyButtonArray.append(pokemonButtonOutlet[i - 1])
            }
        }
        
        //所有的pokemon array
        let pokemonArray = pichuArray + pikachuArray + raichuArray

        //每次有幾個imageView要出現pokemon
        let numberToAdd = Int.random(in: 1...3)
        
        //button: 空的button要隨機出現pokemon
        if emptyButtonArray.count > 7 {
            emptyButtonArray.shuffle()
            for i in 0..<numberToAdd {
                
                //每次隨機出現的pokemon
                let randomPokemon = pokemonArray.randomElement()
                
                // set the random pokemon image
                emptyButtonArray[i].setImage(UIImage(named: "\(randomPokemon ?? "pichu")"), for: .normal)
                
                // set the random pokemon title
                emptyButtonArray[i].setTitle(randomPokemon ?? "pichu", for: .normal)
//                print(emptyButtonArray[i].titleLabel?.text ?? "cannot get button title")

                //每種pokemon出現的時間
                var pokemonAppearTime = 3
                switch randomPokemon {
                case "pikachu":
                    pokemonAppearTime = 2
                case "raichu":
                    pokemonAppearTime = 1
                default:
                    pokemonAppearTime = 3
                }
                
                //只讓該次出現的pokemon消失
                Timer.scheduledTimer(withTimeInterval: TimeInterval(pokemonAppearTime), repeats: false) { (timer) in
                    
                    // let the pokemon image disappear
                    emptyButtonArray[i].setImage(nil, for: .normal)
                    
                    // let the pokemon title disappear
                    emptyButtonArray[i].setTitle(nil, for: .normal)
                }
                
            }
            
        }
        
    }
    
    func showTimesUpAlert(){
        let alert = UIAlertController(title: "TIME'S UP!", message: "Your score is  \(totalScroe)", preferredStyle: .alert)
        let seeResultAction = UIAlertAction(title: "See Result", style: .default) { (alertAction) in
            self.performSegue(withIdentifier: "gameToLeaderboardSG", sender: self)
        }
        
        alert.addAction(seeResultAction)
        present(alert, animated: true, completion: nil )
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }


}

