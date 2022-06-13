//
//  ViewController.swift
//  Color changer
//
//  Created by Stanislav Demyanov on 03.04.2022.
//

import UIKit



class SettingViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var colorMonitor: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    
    // MARK: - Private properties
    private var numberColor: Int = 0
    
    // MARK: - Public Properties
    var color: UIColor!
    var delegate: SettingViewControllerDelegate!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        colorMonitor.layer.cornerRadius = 10
        colorMonitor.backgroundColor = color
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        redSliderSet()
        greenSliderSet()
        blueSliderSet()
        setValueLabel()
        setTextFields()
        
        addButtonOnKeyboard()
    }
    
    // MARK: - IBActions
    
    @IBAction func changeOfRed(_ sender: UISlider) {
        redValueLabel.text = String(format: "%.0f", sender.value)
        redTF.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    @IBAction func changeOfGreen(_ sender: UISlider) {
        greenValueLabel.text = String(format: "%.0f", sender.value)
        greenTF.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    @IBAction func changeOfBlue(_ sender: UISlider) {
        blueValueLabel.text = String(format: "%.0f", sender.value)
        blueTF.text = String(format: "%.0f", sender.value)
        changeColor()
    }
    
    @IBAction func doneButtonOnView(_ sender: UIButton) {
        guard let background = colorMonitor.backgroundColor else { return }
        delegate?.setNewColor(for: background)
    }
    // MARK: - Private Methods
    
    private func redSliderSet() {
        guard let colorPath = color.cgColor.components else { return }
        let redColor = colorPath[0]
        redSlider.setValue(Float(redColor * 255), animated: true)
        redSlider.minimumTrackTintColor = .red
    }
    
    private func greenSliderSet() {
        guard let colorPath = color.cgColor.components else { return }
        let greenColor = colorPath[1]
        greenSlider.setValue(Float(greenColor * 255), animated: true)
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func blueSliderSet() {
        guard let colorPath = color.cgColor.components else { return }
        let blueColor = colorPath[2]
        blueSlider.setValue(Float(blueColor * 255), animated: true)
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func setValueLabel() {
        redValueLabel.text = String(format: "%.0f", redSlider.value)
        greenValueLabel.text = String(format: "%.0f", greenSlider.value)
        blueValueLabel.text = String(format: "%.0f", blueSlider.value)
    }
    
    private func setTextFields() {
        redTF.text = String(format: "%.0f", redSlider.value)
        greenTF.text = String(format: "%.0f", greenSlider.value)
        blueTF.text = String(format: "%.0f", blueSlider.value)
    }
    
    private func changeColor() {
        colorMonitor.backgroundColor = UIColor(red: CGFloat(redSlider.value)/255,
                                               green: CGFloat(greenSlider.value)/255,
                                               blue: CGFloat(blueSlider.value)/255, alpha: 1)
    }
    
    private func invalidColorNumber(_ value: String) -> Bool {
        let regularExpression = "^([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if predicate.evaluate(with: value) {
            return false
        }
        
        return true
    }
    
    private func checkNumber(_ textField: UITextField) {
        if invalidColorNumber(textField.text!) {
            showAlertController()
            textField.text = "96"
        }
    }
}

// MARK: - UITextFieldDelegate

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkNumber(textField)
        
        guard let redValue = redTF.text else { return }
        guard let greenValue = greenTF.text else { return }
        guard let blueValue = blueTF.text else { return }
        
        redValueLabel.text = redValue
        greenValueLabel.text = greenValue
        blueValueLabel.text = blueValue
        
        redSlider.value = Float(redValue)!
        greenSlider.value = Float(greenValue)!
        blueSlider.value = Float(blueValue)!
        
        changeColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - Keyboard settings

extension SettingViewController {
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
        
        redTF.inputAccessoryView = doneToolbar
        greenTF.inputAccessoryView = doneToolbar
        blueTF.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        redTF.resignFirstResponder()
        greenTF.resignFirstResponder()
        blueTF.resignFirstResponder()
    }
}

// MARK: - Alert Controller

extension SettingViewController {
    private func showAlertController() {
        let alertController = UIAlertController(title: "Не правильный диапазон", message: "Введите число от 0 до 255", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
