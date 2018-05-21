//
//  SettingsViewController.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 1/5/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var settings: Settings?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var timeValue: UITextField!
    @IBOutlet weak var maxNumberValue: UITextField!
    @IBOutlet weak var frequencyValue: UITextField!
    @IBOutlet weak var sliderTimer: UISlider!
    @IBOutlet weak var sliderMaxBubbles: UISlider!
    @IBOutlet weak var sliderFrequency: UISlider!
    @IBOutlet weak var nightModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        timeValue.text = String(settings!.time)
        maxNumberValue.text = String(settings!.maxNumber)
        frequencyValue.text = String(settings!.frequency)
        sliderTimer.value = Float(settings!.time)
        sliderMaxBubbles.value = Float(settings!.maxNumber)
        sliderFrequency.value = Float(settings!.frequency)
        // Do any additional setup after loading the view.
    }
    
    func nightMode() {
        if nightModeSwitch.isOn == true {

        }
    }
    
    @IBAction func sliderTimerChanged(_ sender: UISlider) {
        settings?.time = Int(sender.value)
        timeValue.text = String(settings!.time)
    }
    @IBAction func sliderMaxBubblesChanged(_ sender: UISlider) {
        settings?.maxNumber = Int(sender.value)
        maxNumberValue.text = String(settings!.maxNumber)
    }
    @IBAction func sliderFrequencyChanged(_ sender: UISlider) {
        settings?.frequency = Int(sender.value)
        frequencyValue.text = String(settings!.frequency)
    }
}
