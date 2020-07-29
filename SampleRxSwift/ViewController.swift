//
//  ViewController.swift
//  SampleRxSwift
//
//  Created by Roy Cruz on 7/28/20.
//  Copyright © 2020 Roy Cruz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var selectCityButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBAction func selectCityButtonTapped(_ sender: UIButton) {

    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cityStr = UserDefaults.standard.object(forKey:"cityName") as? String ?? ""
        cityLabel.text = cityStr.count > 0 ? "Selected city: \(cityStr)" : ""
    }
    
    func prepareViews() {
        cityLabel.text = ""
        selectCityButton.layer.cornerRadius = 10;
        selectCityButton.clipsToBounds = true;

    }
}

