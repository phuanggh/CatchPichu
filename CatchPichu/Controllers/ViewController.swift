//
//  ViewController.swift
//  CatchPichu
//
//  Created by Penny Huang on 2020/3/21.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var pokemonView: [UIImageView]!
    
    @IBOutlet var pokemonButtonOutlet: [UIButton]!
    
    
    let pichuArray = Array(repeating: "pichu", count: 5)
    let pikachuArray = Array(repeating: "pikachu", count: 3)
    let raichuArray = Array(repeating: "raichu", count: 2)
    var gameTime = 10
    
    // test
    func testFunc(){
        for i in 0 ..< pokemonButtonOutlet.count {
            pokemonButtonOutlet[i].setImage(UIImage(named: "pichu"), for: .normal)
        }
    }
    
    //使用者start遊戲後的動作，每1.5秒show pokemon
    func gameStart() {
//        pokemonButtonOutlet[0].imageView?.image = UIImage(named: "pichu")
        
//        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(showPokemon), userInfo: nil, repeats: true)
        
        // Timer: game countdown
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.gameTime -= 1
            if self.gameTime == 0 {
                timer.invalidate()
                print("time's up")
            }
        }
        
        // Timer: showing pokemon until time's up
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { (timer) in
            self.showPokemon()
            if self.gameTime == 0 {
                timer.invalidate()
                print("stop showing pokemon")
            }
            
        }
    }
    
    //顯示pokemon的圖片
    @objc func showPokemon(){
        
        //找出所有空的imageView
        var emptyView = [UIImageView]()
        for i in 1...pokemonView!.count {
            if pokemonView[i - 1].image == nil {
                emptyView.append(pokemonView[i-1])
                
//                print(pokemonView[i-1].tag)
            }
        }
        
        //所有的pokemon array
        let pokemonArray = pichuArray + pikachuArray + raichuArray

        //每次有幾個imageView要出現pokemon
        let numberToAdd = Int.random(in: 1...3)

        //空的imageView要隨機出現pokemon
        if emptyView.count > 7 {
            emptyView.shuffle()
            for i in 0 ..< numberToAdd {
                
                //每次隨機出現的pokemon
                let randomPokemon = pokemonArray.randomElement()
                emptyView[i].image = UIImage(named: "\(randomPokemon ?? "pichu")")
                
                
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
                    emptyView[i].image = nil
                }
            }
        }
        
//        pokemonDidAppear()
    }
    
    
//    //神奇寶貝顯示後的動作
//    func pokemonDidAppear(){
//        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(hidePokemon), userInfo: nil, repeats: false)
//
//        //Timer依照shownPokeonAppearTime來決定幾秒後叫hidePokemon()
//            // Image.isShown = false
//
//
//    }
//
//    //讓神奇寶貝消失
//    @objc func hidePokemon(){
//        for i in 0 ..< pokemonView!.count{
//            pokemonView[i].image = nil
//        }
//
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if (view.viewWithTag(4) as! UIImageView).image == nil {
//            print("nil")
//        }
        gameStart()

    }


}

