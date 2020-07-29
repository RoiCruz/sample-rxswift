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

    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var selectCityButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
        
    @IBAction func selectCityButtonTapped(_ sender: UIButton) {

    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let cityStr = UserDefaults.standard.object(forKey:"cityName") as? String ?? ""
        cityLabel.text = cityStr.count > 0 ? "Selected city: \(cityStr)" : ""
    }
}

