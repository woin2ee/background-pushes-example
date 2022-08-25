//
//  JokeViewController.swift
//  BackgroundPushes
//
//  Created by Jaewon on 2022/08/25.
//

import UIKit

final class JokeViewController: UIViewController {
    
    private let jokeRepository = JokeRepository.init()
    
    @IBOutlet weak var jokeTableView: UITableView! {
        didSet {
            jokeTableView.dataSource = self
            jokeTableView.delegate = self
        }
    }
    
    var jokes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.jokes = self.jokeRepository.fetchJokes()
    }
}

extension JokeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        var config = cell.defaultContentConfiguration()
        config.text = self.jokes[indexPath.row]
        cell.contentConfiguration = config
        
        return cell
    }
}
