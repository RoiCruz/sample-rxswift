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
    private let cities: BehaviorRelay<[CityModel]> = BehaviorRelay(value: [])
    private var filteredCities: BehaviorRelay<[CityModel]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCities.bind(to: tableView.rx.items(cellIdentifier: "cityCell", cellType: TableViewCell.self)) { row, model, cell in
            let name = model.name
            cell.titleLabel?.text = name
            cell.subtitleLabel?.text = model.country.name
            let index = name.index(name.startIndex, offsetBy: 3)
            let substring = name.prefix(upTo: index)
            cell.avatarLabel?.text = String(substring)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                //let home = self?.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let city:CityModel = (self?.filteredCities.value[indexPath.row])!
                print("RRC \(city.name) row: \(indexPath.row)")
                //home.cityLabel. = city.name
                self?.navigationController?.popViewController(animated: true)
//                self?.navigationController?.popToViewController(home, animated: true)
            }).disposed(by: disposeBag)
        
        
        searchBar
            .rx.text
            .orEmpty
            .subscribe(onNext: { [unowned self] query in // Here we will be notified of every new value
                self.filteredCities.accept( self.cities.value.filter { $0.name.hasPrefix(query) })
                print(self.filteredCities.value)
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        fetchData()
    }
    
    //#MARK: Private Methods
    
//    private func citySelected() {
//
//        self.viewModel.shiftNameText
//            .asObservable()
//            .map { $0 }
//            .bind(to:self.shiftLabel.rx.text)
//            .disposed(by:self.disposeBag)
//
//
//        let home = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        home.cityLabel
//            .subscribe(onNext: { [weak self] city in
//                self?.greetingsLabel.text = "Hello \(character)"
//            }).disposed(by: disposeBag)
//
//        navigationController?.popToViewController(vc, animated: true)
//
//    }
    
    private func fetchData() {
        let session = URLSession.shared
        let url = URL(string: "https://system.bigdish.com/api/regions")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                return
            }
            do {
                let json = try JSONDecoder().decode(Response.self, from: data! )
                let cities = json.data
                self.cities.accept(cities)
                self.filteredCities.accept(cities)
                
                print(json)
            } catch {
                print("JSON serialization error: \(error.localizedDescription)")
            }
        })
        task.resume()
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
