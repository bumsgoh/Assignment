//
//  MainCollectionViewController.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//


import UIKit

private let reuseIdentifier = "MovieCollectionViewCell"

var cellSizeRatio: CGFloat = 2
let cellPadding: CGFloat = 8

class MainCollectionViewController: UICollectionViewController {
    private var sortCode = SortCode.reservationRate
    var width: CGFloat?
    public var movieInformations = [MovieInformation]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private lazy var refreshController: UIRefreshControl = {
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
        collectionView?.addSubview(refreshController)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    refreshControl.endRefreshing()
                }
            case .failure(_):
                self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
            }
        }
    }
}
extension MainCollectionViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellSizeRatio = (traitCollection.verticalSizeClass == .compact) ? 4 : 2
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieInformations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }
        let movie = self.movieInformations[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.outDateLabel.text = "\(movie.date)"
        cell.gradeImageView.image = getGradeImage(grade: movie.grade)
        cell.infoLabel.text = "\(movie.reservationGrade)위 \(movie.userRating) / \(movie.reservationRate)%"
        guard let url = URL(string: movie.thumb) else {
            
            return UICollectionViewCell()
            
        }
        NetworkManager.shared.getImageWithCaching(url: url) { [weak self] (image,error) in
            guard let self = self else { return }
            
            if error != nil {
                self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.invalidData), animated: true, completion: nil)
            }
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailTableViewController = MovieDetailTableViewController()
        movieDetailTableViewController.movieId = self.movieInformations[indexPath.row].id
        navigationController?.pushViewController(movieDetailTableViewController, animated: true)
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthWithoutPadding = collectionView.frame.width - (2 * cellPadding * cellSizeRatio)
        let itemWidth = widthWithoutPadding / cellSizeRatio
        return CGSize(width: itemWidth, height: itemWidth * 2.1)
    }
}

