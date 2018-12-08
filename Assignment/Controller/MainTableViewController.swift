//
//  MainTableViewController.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let cellIdentifier: String = "movieCells"
    var movieInformations: [MovieInformation] = [] {
        didSet {
            DispatchQueue.main.async {
                print(self.movieInformations)
                self.tableView.reloadData()
            }
            
        }
    }
    //var sortCode: SortCode = SortCode.reservationRate
    
    lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action:#selector(scrollDownToRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.addSubview(self.refreshController)
    }
    
   @objc func scrollDownToRefresh(_ refreshControl: UIRefreshControl) {
    
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieList(sortBy: sortCode))
    
        NetworkManager.shared.fetch(with: request, decodeType: APIResponseMovieInformation.self) { [weak self] (result, response) in
            
            switch result {
            case .success(let data):
                self?.movieInformations = data.movies
                OperationQueue.main.addOperation {
                    self?.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            case.failure(let error):
                 self?.present(ErrorHandler.shared.buildErrorAlertController(error: error), animated: true, completion: nil)
            }
        }
    }
}
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130.0
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieInformations.count
        
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainTableViewCell else {
            
            return UITableViewCell.init()
            
        }
        let movieInfo: MovieInformation = self.movieInformations[indexPath.row]
        cell.titleLabel.text = movieInfo.title
        cell.outDateLabel.text = "개봉일: \(movieInfo.date)"
        cell.gradeImageView.image = getGradeImage(grade: movieInfo.grade)
        cell.infoLabel.text = "평점: \(movieInfo.userRating) 예매순위: \(movieInfo.reservationGrade) 예매율: \(movieInfo.reservationRate)"
        guard let url = URL(string: movieInfo.thumb) else {
            
            return UITableViewCell.init()
            
        }
        NetworkManager.shared.getImage(url: url) {(image,error) in
            if let error = error {
                let alert = ErrorHandler.shared.buildErrorAlertController(error: error)
                self.present(alert, animated: true, completion: nil)
            }
                cell.movieImageView.image = image
        }
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC: MovieDetailTableViewController = MovieDetailTableViewController()
        VC.movieId = self.movieInformations[indexPath.row].id
       self.navigationController?.pushViewController(VC, animated: true)
    }
}


