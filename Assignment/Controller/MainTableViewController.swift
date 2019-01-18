//
//  MainTableViewController.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private let cellIdentifier = "movieCells"
    public var movieInformations = [MovieInformation]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action:#selector(scrollDownToRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.addSubview(refreshController)
    }
    
    @objc func scrollDownToRefresh(_ refreshControl: UIRefreshControl) {
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieList(sortBy: sortCode), errorOcurredBlock: {
            
            self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.urlFailure), animated: true, completion: nil)
            
        })
        NetworkManager.shared.fetch(with: request, decodeType: APIResponseMovieInformation.self) { [weak self] (result, response) in
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                self.movieInformations = data.movies
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            case .failure(_):
                self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
            }
        }
    }
}

//MARK:- TableView Setting
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130.0
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieInformations.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainTableViewCell else {
            
            return UITableViewCell()
            
        }
        let movieInfo = movieInformations[indexPath.row]
        cell.titleLabel.text = movieInfo.title
        cell.outDateLabel.text = "개봉일: \(movieInfo.date)"
        cell.gradeImageView.image = getGradeImage(grade: movieInfo.grade)
        cell.infoLabel.text = "평점: \(movieInfo.userRating) 예매순위: \(movieInfo.reservationGrade) 예매율: \(movieInfo.reservationRate)"
        guard let url = URL(string: movieInfo.thumb) else {
            
            return UITableViewCell()
            
        }
        NetworkManager.shared.getImageWithCaching(url: url) { (image,error) in
            if error != nil {
                let alert = ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed)
                self.present(alert, animated: true, completion: nil)
            }
            cell.movieImageView.image = image
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = MovieDetailTableViewController()
        VC.movieId = movieInformations[indexPath.row].id
        navigationController?.pushViewController(VC, animated: true)
    }
}


