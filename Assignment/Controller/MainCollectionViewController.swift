//
//  MainCollectionViewController.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCollectionViewCell"

var cellsPerRow:CGFloat = 2
let cellPadding:CGFloat = 16

class MainCollectionViewController: UICollectionViewController {
    var sortCode: SortCode = SortCode.reservationRate
    var width: CGFloat?
    var movieInformations: [MovieInformation] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(scrollDownToRefresh(_:)),for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        self.collectionView?.addSubview(self.refreshController)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    @objc func scrollDownToRefresh(_ refreshControl: UIRefreshControl) {
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieList(sortBy: sortCode), errorOcurredBlock: {
            self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.urlFailure), animated: true, completion: nil)
        })
        NetworkManager.shared.fetch(with: request,
                                    decodeType: APIResponseMovieInformation.self)
        { [weak self] (result, response) in
            
            switch result {
            case .success(let data):
                self?.movieInformations = data.movies
                OperationQueue.main.addOperation {
                    self?.collectionView.reloadData()
                    refreshControl.endRefreshing()
                }
            case.failure(_ ):
                self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
            }
            
        }
    }
}
extension MainCollectionViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellsPerRow = (traitCollection.verticalSizeClass == .compact) ? 4 : 2
        collectionView.reloadData()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieInformations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {
            
            return UICollectionViewCell.init()
            
        }
        let movie: MovieInformation = self.movieInformations[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.outDateLabel.text = "\(movie.date)"
        cell.gradeImageView.image = getGradeImage(grade: movie.grade)
        cell.infoLabel.text = "\(movie.reservationGrade)위 \(movie.userRating) / \(movie.reservationRate)%"
        guard let url = URL(string: movie.thumb) else {
            
            return UICollectionViewCell.init()
            
        }
        NetworkManager.shared.getImageWithCaching(url: url) { [weak self] (image,error) in
            if error != nil {
                self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.invalidData), animated: true, completion: nil)
            }
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailTableViewController: MovieDetailTableViewController = MovieDetailTableViewController()
        movieDetailTableViewController.movieId = self.movieInformations[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailTableViewController, animated: true)
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthWithoutPadding = self.collectionView.frame.width - (cellPadding + cellPadding * cellsPerRow)
        let itemWidth = widthWithoutPadding / cellsPerRow
        return CGSize(width: itemWidth, height: itemWidth * 2)
    }
}

