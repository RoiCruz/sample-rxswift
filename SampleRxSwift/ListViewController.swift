//
//  ListViewController.swift
//  SampleRxSwift
//
//  Created by Roy Cruz on 7/28/20.
//  Copyright © 2020 Roy Cruz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
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
                let city:CityModel = (self?.filteredCities.value[indexPath.row])!
                UserDefaults.standard.set("\(city.name)", forKey: "cityName")
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        searchBar
            .rx.text
            .orEmpty
            .subscribe(onNext: { [unowned self] query in
                self.filteredCities.accept( self.cities.value.filter { $0.name.hasPrefix(query) })
                self.tableView.keyboardDismissMode = .onDrag
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        fetchData()
    }
    
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
