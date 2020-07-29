//
//  ListViewController.swift
//  SampleRxSwift
//
//  Created by Roi Cruz on 7/28/20.
//  Copyright © 2020 Roy Cruz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        fetchData()
    }
        
    //#MARK: Private Methods
    
    private func citySelected() {
        //         let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //         vc.selectedCity
        //         .subscribe(onNext: { [weak self] city in
        //             self?.greetingsLabel.text = "Hello \(character)"
        //         }).disposed(by: disposeBag)
        //
        //        navigationController?.popToViewController(vc, animated: true)
        
    }
    
    private func fetchData() {
        
        let session = URLSession.shared
        let url = URL(string: "https://system.bigdish.com/api/regions")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check the response
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
            // Check if an error occured
            if error != nil {
                // HERE you can manage the error
                print(error)
                return
            }
            // Serialize the data into an object
            do {

                
                let json = try JSONDecoder().decode(Response.self, from: data! )
                    //try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
            
        })
        task.resume()

        
        
        
//        let urlString = "url"
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url){ data, response, error in
//                if let data = data {
//                    print("data")
//
//                    let decoder = JSONDecoder()
//                    if let json = try? decoder.decode([CityModel].self, from: data)
//                    completion(json)
//                }
//            }.resume()
//        }
//
//
//        let items =  BehaviorRelay(value: [CityModel]())
//        items.asObservable().bind { (Observable<[CityModel]>) -> Result<Any, Failure: Error> in
//            items.value =
//        }
//        items.asObservable.bindTo(....).addDisposableTo(bag)
//
        
        //        let x = UniversityRequest.init()
        //        let request = Observable<[CityModel]>.
        //        x.apiClient.send(apiRequest: request)

    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as? TableViewCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        print(indexPath.section)
        print(indexPath.row)
        
        //dismiss self
        //pass data to main view controller
    }
}
