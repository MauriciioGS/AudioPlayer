//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Proteco on 05/11/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var sliderDuration: UISlider!
    @IBOutlet var sliderVolume: UISlider!
    
    var audioPlayer = AVAudioPlayer()
    // Para ejecutar un código cada cierto tiempo
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarAudio()
    }
    
    func cargarAudio(){
        guard let laURL = Bundle.main.url(forResource: "MUSIC3", withExtension: "mp3")
        else{
            print("Ocurrio un error, no se encuentra el recurso")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: laURL)
            initUI()
        } catch{
            print("Ocurrió un error: \(error.localizedDescription)")
        }
    }
    
    func initUI(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizaSlider), userInfo: nil, repeats: true)
        sliderDuration.value = 0
        sliderDuration.maximumValue = Float(audioPlayer.duration)
        btnStop.isEnabled = false
        btnPlay.isEnabled = true
        audioPlayer.delegate = self
        audioPlayer.volume = 0.5
        sliderVolume.value = 0.5
    }
    
    @objc func actualizaSlider(){
        sliderDuration.value = Float(audioPlayer.currentTime)
    }

    @IBAction func playAction(_ sender: UIButton, forEvent event: UIEvent) {
        audioPlayer.play()
        btnPlay.isEnabled = false
        btnStop.isEnabled = true
    }
    
    @IBAction func stopAction(_ sender: Any, forEvent event: UIEvent) {
        audioPlayer.stop()
        btnPlay.isEnabled = true
        btnStop.isEnabled = false
    }
    @IBAction func sliderDurationChange(_ sender: UISlider, forEvent event: UIEvent) {
        audioPlayer.currentTime = Double(sliderVolume.value)
    }
    
    @IBAction func sliderVolumeChange(_ sender: UISlider, forEvent event: UIEvent) {
        audioPlayer.volume = sliderVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Se desactiva el timer
        timer?.invalidate()
        initUI()
    }
}

