//
//  ViewController.swift
//  CombineIntro
//
//  Created by Noshaid Ali on 28/05/2021.
//

import UIKit
import Combine

class MyCustomTableCell: UITableViewCell {
    
    var company = "" {
        didSet {
            button.setTitle(company, for: .normal)
        }
    }
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //1. what we want to pass back ==> String
    //2. this will never return error
    let action = PassthroughSubject<String, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width-20, height: contentView.frame.size.height-6)
    }
    
    @objc private func didTapButton() {
        action.send(company)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MyCustomTableCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var observers: [AnyCancellable] = []
    var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        
        ApiCaller.shared.fetchCompanies()
            .receive(on: DispatchQueue.main) //this will execute code on main thread
            .sink(receiveCompletion: { (completion) in
                switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print(error)
                }
            }, receiveValue: { [weak self] (value) in
                print("Received")
                self?.models = value
                self?.tableView.reloadData()
            }).store(in: &observers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomTableCell else {
            fatalError()
        }
        cell.company = models[indexPath.row]
        // In the sink there is only receive closure bcz we define action as never result error
        cell.action.sink { (companyName) in
            print(companyName)
        }.store(in: &observers)
        return cell
    }
}

