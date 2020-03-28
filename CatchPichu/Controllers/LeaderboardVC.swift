//
//  LeaderboardVC.swift
//  CatchPichu
//
//  Created by Penny Huang on 2020/3/22.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class LeaderboardVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet var lastResultLabel: [UILabel]!
    
    
    @IBOutlet var rankLabel: [UILabel]!
    
    @IBAction func returnButtonPressed(_ sender: Any) {

    }
    
    
    func displayLastResult(){
        
        // Check if there are previous game results
        if defaults.array(forKey: "ResultArray") != nil {
            let latestResultArray = defaults.array(forKey: "ResultArray") as! [Int]
            lastResultLabel[0].text = "PICHU: \(latestResultArray[0])"
            lastResultLabel[1].text = "PIKACHU: \(latestResultArray[1])"
            lastResultLabel[2].text = "RAICHU: \(latestResultArray[2])"
            lastResultLabel[3].text = "SCORE: \(latestResultArray[3])"
        } else {
            lastResultLabel[0].text = "PICHU: 0"
            lastResultLabel[1].text = "PIKACHU: 0"
            lastResultLabel[2].text = "RAICHU: 0"
            lastResultLabel[3].text = "SCORE: 0"
        }
        
        
    }
    
    func displayRank(){
        if defaults.array(forKey: "ScoreArray") != nil {
            let scoreArray = defaults.array(forKey: "ScoreArray") as! [Int]
            rankLabel[0].text = "1st \(scoreArray[0])"
            rankLabel[1].text = "2nd \(scoreArray[1])"
            rankLabel[2].text = "3rd \(scoreArray[2])"
            rankLabel[3].text = "4th \(scoreArray[3])"
            rankLabel[4].text = "5th \(scoreArray[4])"
        } else {
            rankLabel[0].text = "1st 0"
            rankLabel[1].text = "2nd 0"
            rankLabel[2].text = "3rd 0"
            rankLabel[3].text = "4th 0"
            rankLabel[4].text = "5th 0"
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLastResult()
        displayRank()
        
//        print(latestResultArray ?? "cannot find the latest result in UserDefault")
//        print(scoreArray ?? "cannot find score array in UserDefault")

    }
    
}
