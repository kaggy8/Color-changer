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
    @IBOutlet weak var redTextfield: UITextField!
    @IBOutlet weak var greenTextfield: UITextField!
    @IBOutlet weak var blueTextfield: UITextField!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMonitor.layer.cornerRadius = 10
        
        redSliderSet()
        greenSliderSet()
        blueSliderSet()
        setValueLabel()
        changeColor()
        
        addButtonOnKeyboard()
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
        redTextfield.text = redValueLabel.text
    }
    
    private func greenSliderSet() {
        greenSlider.setValue(144, animated: true)
        greenSlider.maximumValue = 255
        greenSlider.minimumTrackTintColor = .green
        greenTextfield.text = greenValueLabel.text
    }
    
    private func blueSliderSet() {
        blueSlider.setValue(235, animated: true)
        blueSlider.maximumValue = 255
        blueSlider.minimumTrackTintColor = .blue
        blueTextfield.text = blueValueLabel.text
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

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
}

// MARK: - Keyboard settings

extension ViewController {
    private func addButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: UIScreen.main.bounds.width,
                                                  height: 50))
        doneToolbar.barStyle = .default
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace,
                                            target: nil,
                                            action: nil)
        let done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexibleSpace, done]
        flexibleSpace.width = UIScreen.main.bounds.width - done.width
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        redTextfield.inputAccessoryView = doneToolbar
        greenTextfield.inputAccessoryView = doneToolbar
        blueTextfield.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        redTextfield.resignFirstResponder()
        greenTextfield.resignFirstResponder()
        blueTextfield.resignFirstResponder()
    }
}
