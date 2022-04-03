//
//  ViewController.swift
//  Color changer
//
//  Created by Stanislav Demyanov on 03.04.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var colorMonitor: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    // MARK: - Private properties
    
    private var redNumber: CGFloat = 0
    private var greenNumber: CGFloat = 0
    private var blueNumber: CGFloat = 0
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMonitor.layer.cornerRadius = 10
        
        redSliderSet()
        greenSliderSet()
        blueSliderSet()
    }
    
    // MARK: - IBActions
    
    @IBAction func changeOfRed(_ sender: UISlider) {
        redNumber = CGFloat(sender.value)
        redValueLabel.text = String(format: "%.0f", sender.value)
        
        changeColor()
    }
    
    @IBAction func changeOfGreen(_ sender: UISlider) {
        greenNumber = CGFloat(sender.value)
        greenValueLabel.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    @IBAction func changeOfBlue(_ sender: UISlider) {
        blueNumber = CGFloat(sender.value)
        blueValueLabel.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    // MARK: - Private Methods
    
    private func redSliderSet() {
        redSlider.value = 255
        redSlider.maximumValue = 255
        redSlider.minimumTrackTintColor = .red
    }
    
    private func greenSliderSet() {
        greenSlider.value = 255
        greenSlider.maximumValue = 255
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func blueSliderSet() {
        blueSlider.value =  255
        blueSlider.maximumValue = 255
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func changeColor() {
        colorMonitor.backgroundColor = UIColor(red: redNumber/255, green: greenNumber/255, blue: blueNumber/255, alpha: 1)
    }
    
}

