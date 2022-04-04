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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMonitor.layer.cornerRadius = 10
        
        redSliderSet()
        greenSliderSet()
        blueSliderSet()
        setValueLabel()
        changeColor()
    }
    
    // MARK: - IBActions
    
    @IBAction func changeOfRed(_ sender: UISlider) {
        redValueLabel.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    @IBAction func changeOfGreen(_ sender: UISlider) {
        greenValueLabel.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    @IBAction func changeOfBlue(_ sender: UISlider) {
        blueValueLabel.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    // MARK: - Private Methods
    
    private func redSliderSet() {
        redSlider.setValue(100, animated: true)
        redSlider.maximumValue = 255
        redSlider.minimumTrackTintColor = .red
    }
    
    private func greenSliderSet() {
        greenSlider.setValue(144, animated: true)
        greenSlider.maximumValue = 255
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func blueSliderSet() {
        blueSlider.setValue(235, animated: true)
        blueSlider.maximumValue = 255
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func setValueLabel() {
        redValueLabel.text = String(format: "%.0f", redSlider.value)
        greenValueLabel.text = String(format: "%.0f", greenSlider.value)
        blueValueLabel.text = String(format: "%.0f", blueSlider.value)
    }
    
    private func changeColor() {
        colorMonitor.backgroundColor = UIColor(red: CGFloat(redSlider.value)/255, green: CGFloat(greenSlider.value)/255, blue: CGFloat(blueSlider.value)/255, alpha: 1)
    }

}

