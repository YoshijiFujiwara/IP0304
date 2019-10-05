//
//  JankenViewController.swift
//  IH03041
//
//  Created by 藤原吉司 on 2019/09/12.
//  Copyright © 2019 local.hal. All rights reserved.
//

import UIKit
import AVFoundation

class JankenViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var jankenImage: UIImageView!
    
    var jankenponPlayer:AVAudioPlayer!
    // 現在表示されている画像
    var currentImage:String!
    
    @IBOutlet weak var myLabel: UILabel!
    let guImage = UIImage(named: "gu")
    let chokiImage = UIImage(named: "choki")
    let paImage = UIImage(named: "pa")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hogehoge")
        
        let audioPath = Bundle.main.path(forResource: "jankenpon", ofType: "mp3")!
         print("view did load finish")
        let jankenponUrl = URL(fileURLWithPath: audioPath)
         print(jankenponUrl)
        do {
            jankenponPlayer = try AVAudioPlayer(contentsOf: jankenponUrl)
            print("ぴよぴよ")
        } catch let error as NSError {
            print(error.code)
        }
        jankenponPlayer.delegate = self
        
        // 初期はぐーかな
        jankenImage.image = guImage
        currentImage = "gu"

        
        print("view did load finish")
    }
    
    @IBAction func jankenPlay(_ sender: Any) {
        myLabel.text = "ジャンケン、、、"
        jankenponPlayer.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //音がなり終わってからの処理  //画像を設定
        var newAnserNumber:UInt32 = 0
        var tempImage = currentImage
        
        while(tempImage == currentImage) {
            newAnserNumber=arc4random_uniform(3)
            switch newAnserNumber {
            case 0:
                tempImage = "gu"
                
            case 1:
                tempImage = "choki"
                
            case 2:
                tempImage = "pa"
            default:
                continue
            }
        }
        
        switch newAnserNumber {
        case 0:
            jankenImage.image = guImage
            
        case 1:
            jankenImage.image = chokiImage
            
        case 2:
            jankenImage.image = paImage
        default:
            print("cannot be default")
        }
        
        currentImage = tempImage
        
        switch currentImage {
        case "gu":
            myLabel.text = "グー！"
        case "choki":
            myLabel.text = "チョキ！"
        case "pa":
            myLabel.text = "パー！"
        default:
            print("hoge")
        }
    }

}
