//
//  MovieDetailViewController.swift
//  EdWithProject5
//
//  Created by 고상범 on 2018. 8. 24..
//  Copyright © 2018년 고상범. All rights reserved.
//
/*
import UIKit

class MovieDetailTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    let dispatchGroup = DispatchGroup()
    var movieDetailData: MovieDetailData?
    var movieId: String = ""
    let cellIdentifier = "commentCell"
    let synopsisCellIdentifier = "synopsisCell"
    let actorAndDirectorCellIdentifier = "actorAndDirectorCell"
    var movieCommentData: [MovieCommentData] = []
    var informationViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var synopsisViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    let numberFormatter: NumberFormatter = {
        let formatter =  NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
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

    let detailInfoView: DetailInfoView = {
        let view = DetailInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 250
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        UISetUp()
        UIAfterGetData()
    }
    

    @objc func movieImageClicked() {
        let popUpVC: PopUpImageViewController = PopUpImageViewController()
            popUpVC.fullScreenImageView.image = detailInfoView.movieImageView.image
        self.present(popUpVC, animated: false, completion: nil)
    }
    
    @objc func writeButtonPressed() {
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
        self.navigationController?.present(navi, animated: true, completion: nil)
    }
    
    func showErrorAlertWindow(error: Error) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: "데이터 불러오기 오류", message: "데이터를 정상적으로 불러오지 못했습니다 Error: \(error.localizedDescription)", preferredStyle: .alert)
        let checkAction: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(checkAction)
        OperationQueue.main.addOperation {
            self.present(alertController, animated: true, completion: nil)
            return
        }
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
            guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentTableViewCell else {return UITableViewCell.init()}
            let time: Double = movieCommentData[indexPath.row].timestamp
            let date = Date(timeIntervalSince1970: time)
            if movieCommentData[indexPath.row].writer.isEmpty {
                cell.titleLabel.text = "익명"
            } else {
                cell.titleLabel.text = movieCommentData[indexPath.row].writer
            }
            cell.ratingBarView.rating = Float(movieCommentData[indexPath.row].rating)/2
            cell.dateLabel.text = formatter.string(from: date)
            cell.commentTextView.text = movieCommentData[indexPath.row].contents
            return cell
        default:
            return UITableViewCell.init()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return 170
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
        
        self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.55).isActive = true
        
        self.informationHeadView.addSubview(detailInfoView)
        self.detailInfoView.widthAnchor.constraint(equalTo: self.informationHeadView.widthAnchor, multiplier: 1).isActive = true
        self.detailInfoView.heightAnchor.constraint(equalTo: self.informationHeadView.heightAnchor, multiplier: 0.98).isActive = true
        self.detailInfoView.movieImageView.isUserInteractionEnabled = true
        self.detailInfoView.movieImageView.addGestureRecognizer(gestureRecognizer)
        
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
            self.indicator.stopAnimating()
            guard let movieData = self.movieDetailData else {return}
            guard let audienceNumber: String = self.numberFormatter.string(from: movieData.audience as NSNumber) else {return}
            self.movieId = movieData.id
            self.detailInfoView.titleLabel.text = "\(movieData.title)"
            self.detailInfoView.gradeImageView.image = getGradeImage(grade: movieData.grade)
            self.detailInfoView.outDateLabel.text = "\(movieData.date) 개봉"
            self.detailInfoView.runningTimeLabel.text = "\(movieData.genre)/\(movieData.duration) 분"
            self.detailInfoView.reservationRateLabel.text = "\(movieData.reservationRate)"
            self.detailInfoView.ratingBar.rating = Float(movieData.userRating)/2
            self.detailInfoView.ratingPointLabel.text = "\(movieData.userRating)"
            self.detailInfoView.audienceNumberLabel.text = "\(audienceNumber)"
            self.navigationItem.title = "\(movieData.title)"
            self.tableView.reloadData()
        }
    }
    
    func getMovieDetailData() {
        self.dispatchGroup.enter()
        NetworkManager.shared.getMovieDetailData(movieId: movieId, completion: {(data,error) in
            if let error = error {
                OperationQueue.main.addOperation {
                    self.showErrorAlertWindow(error: error)
                    self.indicator.stopAnimating()
                }
            }
            guard let dataStruct = data else {return}
            self.movieDetailData = dataStruct
            self.dispatchGroup.enter()
            guard let imageURL: URL = URL(string: dataStruct.image) else {return}
            NetworkManager.shared.getImage(url: imageURL, completion: {(image,err) in
                guard let image = image else {return}
                print("image done1")
                OperationQueue.main.addOperation {
                    self.detailInfoView.movieImageView.image = image
                    print("image done2")
                }
                self.dispatchGroup.leave()
            })
            print("data done")
            self.dispatchGroup.leave()
        })
    }
    
    func getCommentData(){
        self.dispatchGroup.enter()
        NetworkManager.shared.getMovieDataIncludingComments(movieId: movieId, completion: {(data,error) in
            if let error = error {
                self.showErrorAlertWindow(error: error)
            }
            guard let dataArray = data else {return}
            self.movieCommentData = dataArray
            print("comment done")
            self.dispatchGroup.leave()
        })
    }
}

extension MovieDetailTableViewController: WritingDoneDelegate {
    
    func writeDone() {
        NetworkManager.shared.getMovieDataIncludingComments(movieId: movieId, completion: {(data,error) in
            if let error = error {
                self.showErrorAlertWindow(error: error)
            }
            guard let dataArray = data else {return}
            OperationQueue.main.addOperation {
                self.movieCommentData = dataArray
                self.tableView.reloadData()
            }
        })
    }
}




*/
