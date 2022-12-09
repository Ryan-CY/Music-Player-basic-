//
//  MusicPlayerViewController.swift
//  Music Player(basic)
//
//  Created by Ryan Lin on 2022/12/9.
//

import UIKit
//載入AVFoundation函式庫(framework)
import AVFoundation

class MusicPlayerViewController: UIViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var songPhotoImageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var songs = ["崖上的波妞", "因為你 所以我", "The End of the World"]
    
    var index = 1
    
    enum Singers : String {
        case 青峰
        case 五月天
        case 戴維絲
    }
    
    //把型別 AVPlayer 存入常數 player，就可使用AVPlayer()裡的功能
    let player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songPhotoImageView.layer.cornerRadius = CGFloat(20)
        shadowView.layer.cornerRadius = CGFloat(20)
        shadowView.layer.shadowOpacity = Float(1)
        shadowView.layer.shadowRadius = CGFloat(20)
        shadowView.layer.shadowColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        
    }
    
    fileprivate func playMusic() {
        //四個步驟播放音樂
        //1.透過 Bundle.main 讀取程式本生的資料夾，找到音樂mp3檔的url路徑
        let fileUrl = Bundle.main.url(forResource: songs[index], withExtension: "mp3")!
        //2.利用 AVPlayerItem 生成要播放的音樂
        let playerItem = AVPlayerItem(url: fileUrl)
        //3.設定 player 要播放的 AVPlayerItem
        player.replaceCurrentItem(with: playerItem)
        //4.開始播放
        player.play()
        
        //button顯示暫停圖示
        playPauseButton.configuration?.image = UIImage(systemName: "pause.fill")
        //顯示歌曲對應的圖示
        songPhotoImageView.image = UIImage(named: songs[index])
        //顯示歌曲名稱
        songLabel.text = String(songs[index])
        //用switch讓歌手與歌曲對上
        switch songs[index] {
        case "崖上的波妞" :
            singerLabel.text = String(Singers.青峰.rawValue)
        case "因為你 所以我":
            singerLabel.text = String(Singers.五月天.rawValue)
        case "The End of the World":
            singerLabel.text = String(Singers.戴維絲.rawValue)
        default:
            break
        }
    }
    
    @IBAction func shuffleButton(_ sender: Any) {
        //讓songs array裡改變順序
        songs.shuffle()
        playMusic()
    }
    
    @IBAction func playButtonChosen(_ sender: UIButton) {
        
        switch player.timeControlStatus {
            //狀態是播放中時
        case .playing :
            //暫停播放
            player.pause()
            //button顯示播放圖示
            sender.configuration?.image = UIImage(systemName: "play.fill")
            //裝態不是在播放中時
        default:
            playMusic()
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        index = (index + 1)%songs.count
        playMusic()
    }
    
    @IBAction func preButton(_ sender: Any) {
        index = (index+songs.count-1)%songs.count
        playMusic()
    }
    
    @IBAction func changeVolumeSlider(_ sender: UISlider) {
        player.volume = sender.value
    }
}
