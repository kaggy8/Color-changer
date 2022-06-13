//
//  MainViewController.swift
//  Color changer
//
//  Created by Stanislav Demyanov on 11.06.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setNewColor(for backgroundColor: UIColor)
}

class MainViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SettingViewController
        destination.delegate = self
        destination.color = view.backgroundColor
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }
}

extension MainViewController: SettingViewControllerDelegate {
    func setNewColor(for backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
    }
}
