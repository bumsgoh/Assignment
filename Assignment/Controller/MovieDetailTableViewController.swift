//
//  MovieDetailViewController.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 24..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    let dispatchGroup = DispatchGroup()
    var movieDetailData: MovieDetailData?
    //var movDetailData: MovieDetailData?
    var movieId: String = ""
    let cellIdentifier = "commentCell"
    let synopsisCellIdentifier = "synopsisCell"
    let actorAndDirectorCellIdentifier = "actorAndDirectorCell"
    var movieCommentData: [MovieCommentData] = []
    var informationViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var synopsisViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY-MM-dd a hh:mm"
        return formatter
    }()
    
    lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(self.movieImageClicked))
        return recognizer
    }()
    
    let informationHeadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
        return view
    }()
    
    let detailMovieInformationView: DetailMovieInformationView = {
        guard let view = Bundle.main.loadNibNamed("DetailMovieInformationView", owner: self, options: nil)?.first as? DetailMovieInformationView else {
            
            return DetailMovieInformationView.init()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableView.automaticDimension
        UISetUp()
        UIAfterGetData()
    }
    

    @objc func movieImageClicked() {
        let popUpVC: PopUpImageViewController = PopUpImageViewController()
            popUpVC.fullScreenImageView.image = detailMovieInformationView.movieImageView.image
        self.present(popUpVC, animated: false, completion: nil)
    }
    
    @objc func writeButtonPressed() {/*
        let VC: CommentInputViewController = CommentInputViewController()
        guard let ratingString: NSString = CommentInformation.shared.rating as NSString? else {return}
        VC.navigationItem.title = "한줄평 작성"
        VC.navigationController?.isNavigationBarHidden = false
        VC.movieTitleLabel.text = detailInfoView.titleLabel.text
        VC.gradeImageView.image = detailInfoView.gradeImageView.image
        VC.controlRatingBar.rating = ratingString.floatValue/2
        VC.ratingCountLabel.text = CommentInformation.shared.rating
        VC.nameTextField.text = CommentInformation.shared.id
        VC.commentTextField.text = CommentInformation.shared.comment
        VC.movieId = movieId
        VC.writeDoneDelegate = self
        VC.navigationItem.title = "한줄평"
        
        let backItem = UIBarButtonItem(title: "취소:", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        let navi = UINavigationController(rootViewController: VC)
        self.navigationController?.present(navi, animated: true, completion: nil)*/
    }
}

extension MovieDetailTableViewController {
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.tableView.tableHeaderView?.layoutIfNeeded()
            self.tableView.tableHeaderView = self.tableView.tableHeaderView
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        case 2:
            print("how many? \(self.movieCommentData.count)")
            return self.movieCommentData.count
        default:
            return 0
        }
}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieData = self.movieDetailData else {return UITableViewCell.init()}
        
        switch indexPath.section {
        case 0:
            let cell: SynopsisTableViewCell = SynopsisTableViewCell()
            cell.sizeToFit()
            cell.synopsisTextView.text = movieData.synopsis
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell: ActorAndDirectorTableViewCell = ActorAndDirectorTableViewCell()
            cell.backgroundColor = UIColor.lightGray
            cell.directorLabel.text = movieData.director
            cell.actorLabel.text = movieData.actor
            cell.isUserInteractionEnabled = true
            cell.tableViewHeadButton.addTarget(self, action: #selector(writeButtonPressed), for: .touchUpInside)
            return cell
        case 2:
            guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentTableViewCell else {
                
                return UITableViewCell.init()
                
            }
            let commentData = movieCommentData[indexPath.row]
            cell.movieCommentData = commentData
           // let time: Double = movieCommentData[indexPath.row].timestamp
           // let date = Date(timeIntervalSince1970: time)
           // if movieCommentData[indexPath.row].writer.isEmpty {
             //   cell.userIdLabel.text = "익명"
            //} else {
              //  cell.userIdLabel.text = movieCommentData[indexPath.row].writer
            //}
            //cell.starRatingPoint = Float(movieCommentData[indexPath.row].rating)/2
           // cell.timeLabel.text = formatter.string(from: date)
            //cell.commentTextView.text = movieCommentData[indexPath.row].contents
            return cell
        default:
            return UITableViewCell.init()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 170.0
        case 2:
            return 170.0
        default:
            return 0.0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

//MARK:-UI Data Setting
extension MovieDetailTableViewController {
    
    func UISetUp() {
        self.tableView.tableHeaderView = informationHeadView
        self.tableView.tableHeaderView?.isUserInteractionEnabled = true
        self.informationHeadView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        self.informationHeadView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor, multiplier: 1).isActive = true
        self.informationHeadView.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor).isActive = true
        self.informationHeadView.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor).isActive = true
        
        self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.45).isActive = true
        
        self.informationHeadView.addSubview(detailMovieInformationView)
        detailMovieInformationView.backgroundColor = UIColor.white
        self.detailMovieInformationView.widthAnchor.constraint(equalTo: self.informationHeadView.widthAnchor, multiplier: 1).isActive = true
        self.detailMovieInformationView.heightAnchor.constraint(equalTo: self.informationHeadView.heightAnchor, multiplier: 0.98).isActive = true
        self.detailMovieInformationView.movieImageView.isUserInteractionEnabled = true
        self.detailMovieInformationView.movieImageView.addGestureRecognizer(gestureRecognizer)
        
        self.tableView.addSubview(indicator)
        self.indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
  
    func UIAfterGetData() {
        self.indicator.startAnimating()
        self.getMovieDetailData()
        self.getCommentData()
        
        dispatchGroup.notify(queue: .main) {
            print("shit")
            self.indicator.stopAnimating()
            guard let movieData = self.movieDetailData else {
              
                return
                
            }
            print("Queue")
            self.movieId = movieData.id
            let data: MovieDetailData = MovieDetailData(director: movieData.director, date: movieData.date, id: movieData.id, title: movieData.title, audience: movieData.audience, actor: movieData.actor, duration: movieData.duration, synopsis: movieData.synopsis, genre: movieData.genre, grade: movieData.grade, image: movieData.image, reservationGrade: movieData.reservationGrade, reservationRate: movieData.reservationRate, userRating: movieData.userRating)
            self.detailMovieInformationView.movieDetailInformations = data
            self.navigationItem.title = "\(movieData.title)"
            self.tableView.reloadData()
        }
    }
    
    func getMovieDetailData() {
        self.dispatchGroup.enter()
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieDetailData(movieId: movieId))
        NetworkManager.shared.fetch(with: request, decodeType: MovieDetailData.self) { [weak self] (result, response) in
            switch result {
            case .success(let data):
                guard let imageURL: URL = URL(string: data.image) else {
                        
                    return
                        
                }
                NetworkManager.shared.getImage(url: imageURL) {[weak self] (image,err) in
                    guard let image = image else {
                           
                        return
                            
                    }
                    OperationQueue.main.addOperation {
                        self?.movieDetailData = data
                        self?.detailMovieInformationView.movieImageView.image = image
                        self?.detailMovieInformationView.movieDetailInformations = self?.movieDetailData
                        print("image all set")
                        self?.dispatchGroup.leave()
                        }
                    }
                
            case.failure(let error):
                OperationQueue.main.addOperation {
                    self?.indicator.stopAnimating()
                    self?.present(ErrorHandler.shared.buildErrorAlertController(error: error), animated: true, completion: nil)
                }
                self?.dispatchGroup.leave()
            }
        }
    }
    
    func getCommentData(){
        self.dispatchGroup.enter()
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieDataIncludingComments(movieId: movieId))
        NetworkManager.shared.fetch(with: request, decodeType: APIResponseMovieCommentData.self) { [weak self] (result, response) in
            switch result {
            case .success(let data):
                self?.movieCommentData = data.comments
                OperationQueue.main.addOperation {
                    self?.indicator.stopAnimating()
                    print("comment set")
                }
                self?.dispatchGroup.leave()
            case.failure(let error):
                OperationQueue.main.addOperation {
                    self?.indicator.stopAnimating()
                self?.present(ErrorHandler.shared.buildErrorAlertController(error: error), animated: true, completion: nil)
                }
                self?.dispatchGroup.leave()
            }
        }
    }

}




