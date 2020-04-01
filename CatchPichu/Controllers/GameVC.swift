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
    
    
    let pichuArray = Array(repeating: Pokemon.pichu, count: 6)
    let pikachuArray = Array(repeating: Pokemon.pikachu, count: 3)
    let raichuArray = Array(repeating: Pokemon.raichu, count: 1)
    var gameTime = 35
    
    var pichuNum = 0
    var pikachuNum = 0
    var raichuNum = 0
    var totalScroe = 0
    
    let player = AVPlayer()
    
    let defaults = UserDefaults.standard
    
    
    @IBAction func StartButtonPressed(_ sender: UIButton) {
        playMusic()
        gameStart()
        sender.isHidden = true
    }
    
    
    @IBAction func pokemonButtonPressed(_ sender: UIButton) {
        
        let pokemonHit = pokemonButtonOutlet[sender.tag - 1]
        
        if pokemonHit.currentImage != nil {

            // Set the score of each pokemon
            switch pokemonHit.titleLabel?.text {
            case Pokemon.pikachu.name:
                totalScroe += Pokemon.pikachu.score
                pikachuNum += 1
            case Pokemon.raichu.name:
                totalScroe += Pokemon.raichu.score
                raichuNum += 1
            default:
                totalScroe += Pokemon.pichu.score
                pichuNum += 1
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
    
    
    
    // The actions when game starts
    func gameStart() {
        
        // Timer: game countdown
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.gameTime -= 1
            self.gameTimeLabel.text = String(self.gameTime)
            if self.gameTime == 0 {
                timer.invalidate()
                self.showTimesUpAlert()
                self.player.pause()
            }
        }
        
        // Timer: showing pokemon until time's up
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.5...1.5), repeats: true) { (timer) in
            self.showPokemon()
            if self.gameTime == 0 {
                timer.invalidate()
                
                //all pokemon disappear when time's up
                for i in 0..<self.pokemonButtonOutlet.count {
                    self.pokemonButtonOutlet[i].setImage(nil, for: .normal)
                    self.pokemonButtonOutlet[i].isEnabled = false
                }

            }
            
        }
    }
    
    // Show pokemon image
    @objc func showPokemon(){
        
        //button: find all the empty button
        var emptyButtonArray = [UIButton]()
        for i in 1...pokemonButtonOutlet.count {
            if pokemonButtonOutlet[i - 1].currentImage == nil {
                emptyButtonArray.append(pokemonButtonOutlet[i - 1])
            }
        }
        
        // Generate weighted random pokemon
        let pokemonArray = pichuArray + pikachuArray + raichuArray

        // random number of pokemon to appear
        let numberToAdd = Int.random(in: 1...3)
        
        //button: random empty button to show pokemon
        if emptyButtonArray.count > 6 {
            emptyButtonArray.shuffle()
            for i in 0..<numberToAdd {
                
                // Generate random pokemon to show
                let randomPokemon = pokemonArray.randomElement()
                
                // Set the random pokemon image
                emptyButtonArray[i].setImage(UIImage(named: "\(randomPokemon?.name ?? "pichu")"), for: .normal)
                
                // Set the random pokemon title
                emptyButtonArray[i].setTitle(randomPokemon?.name ?? "pichu", for: .normal)

                // Appear time of each type of pokemon
                var pokemonAppearTime: Float = 3.0
                switch randomPokemon {
                case Pokemon.pikachu:
                    pokemonAppearTime = Pokemon.pikachu.appearTime
                case Pokemon.raichu:
                    pokemonAppearTime = Pokemon.raichu.appearTime
                default:
                    pokemonAppearTime = Pokemon.pichu.appearTime
                }
                
                // Timer: count down each pokemon's appear time
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
            
            self.storeLatestResult()
            self.storeRank()
            self.performSegue(withIdentifier: "gameToLeaderboardSG", sender: self)
        }
        
        alert.addAction(seeResultAction)
        present(alert, animated: true, completion: nil )
        
    }
    
    func storeLatestResult(){
        let resultArray = [pichuNum, pikachuNum, raichuNum, totalScroe]
        defaults.set(resultArray, forKey: "ResultArray")
    }
    
    func storeRank() {
        
        var temp: Int!
        var comparedScore = totalScroe
        
        // Check if the app is played for the first time on the device
        if defaults.array(forKey: "ScoreArray") != nil {
            
            var scoreArray =  defaults.array(forKey: "ScoreArray")as! [Int]
            
            for i in 0 ..< 5 {
                
                if comparedScore >= scoreArray[i] {
                    temp = scoreArray[i]
                    scoreArray[i] = comparedScore
                    comparedScore = temp
                }
            }
            defaults.set(scoreArray, forKey: "ScoreArray")
        
        } else {
            // Build a UserDefault if user plays for the first time
            let scoreArray = [comparedScore, 0, 0, 0, 0]
            defaults.set(scoreArray, forKey: "ScoreArray")
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimeLabel.text = String(gameTime)

    }


}

