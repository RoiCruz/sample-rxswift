//
//  ViewController.swift
//  SampleRxSwift
//
//  Created by Roi Cruz on 7/28/20.
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
    
    var selectedCityString: String!
    
    @IBAction func selectCityButtonTapped(_ sender: UIButton) {

        //show list of cities
        //do API calls
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


}

