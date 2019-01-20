//
//  MovieDetailViewController.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    let dispatchGroup = DispatchGroup()
    let cellIdentifier = "commentCell"
    let synopsisCellIdentifier = "synopsisCell"
    let actorAndDirectorCellIdentifier = "actorAndDirectorCell"
    var tableHeaderViewHeightAnchor: NSLayoutConstraint = NSLayoutConstraint.init()
    var movieCommentData: [MovieCommentData] = []
    var informationViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var synopsisViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var movieDetailData: MovieDetailData = MovieDetailData()
    var movieId: String = ""
    
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
    
    var informationHeadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let detailMovieInformationView: DetailMovieInformationView = {
        guard let view = Bundle.main.loadNibNamed("DetailMovieInformationView", owner: self, options: nil)?.first as? DetailMovieInformationView else {
            
            return DetailMovieInformationView.init()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewWillAppear(_ animated: Bool) {
        if self.traitCollection.verticalSizeClass == .compact {
            self.tableHeaderViewHeightAnchor.isActive = false
            self.tableHeaderViewHeightAnchor = self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.8)
            self.tableHeaderViewHeightAnchor.isActive = true
        } else {
            self.tableHeaderViewHeightAnchor.isActive = false
            self.tableHeaderViewHeightAnchor = self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.45)
            self.tableHeaderViewHeightAnchor.isActive = true
        }
    }
    
    /*
     popVC처럼 View Controller를 줄여서 쓰는건 오브젝트 씨 스타일이라, popViewController라고 써주는게 좋을것 같습니다.
     */
    @objc func movieImageClicked() {
        let popUpVC: PopUpImageViewController = PopUpImageViewController()
            popUpVC.fullScreenImageView.image = detailMovieInformationView.movieImageView.image
        self.present(popUpVC, animated: false, completion: nil)
    }
}

extension MovieDetailTableViewController {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            if self.traitCollection.verticalSizeClass == .compact {
                
                self.tableHeaderViewHeightAnchor.isActive = false
                self.tableHeaderViewHeightAnchor = self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.8)
                self.tableHeaderViewHeightAnchor.isActive = true
            } else {
                self.tableHeaderViewHeightAnchor.isActive = false
                self.tableHeaderViewHeightAnchor = self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.45)
                self.tableHeaderViewHeightAnchor.isActive = true
            }
            //레이아웃을 다시 잡은 헤더뷰를 재 할당 해줌으로 화면 회전시 다시 레이아웃할 수 있도록 해줍니다.
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
        switch indexPath.section {
        case 0:
            let cell: SynopsisTableViewCell = SynopsisTableViewCell()
            cell.sizeToFit()
            cell.synopsisTextView.text = movieDetailData.synopsis
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell: ActorAndDirectorTableViewCell = ActorAndDirectorTableViewCell()
            cell.directorLabel.text = movieDetailData.director
            cell.actorLabel.text = movieDetailData.actor
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentTableViewCell else {
                
                return UITableViewCell.init()
                
            }
            let commentData = movieCommentData[indexPath.row]
            cell.movieCommentData = commentData
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
            return 150.0
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
    
   private func UISetUp() {
        self.tableView.tableHeaderView = informationHeadView
        self.tableView.tableHeaderView?.isUserInteractionEnabled = true
        self.informationHeadView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        self.informationHeadView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor, multiplier: 1).isActive = true
        self.tableHeaderViewHeightAnchor = self.informationHeadView.heightAnchor.constraint(equalTo: self.tableView.heightAnchor, multiplier: 0.35)
        tableHeaderViewHeightAnchor.isActive = true
        self.informationHeadView.addSubview(detailMovieInformationView)
        
        self.detailMovieInformationView.backgroundColor = UIColor.white
        self.detailMovieInformationView.widthAnchor.constraint(equalTo: self.informationHeadView.widthAnchor, multiplier: 1).isActive = true
        self.detailMovieInformationView.heightAnchor.constraint(equalTo: self.informationHeadView.heightAnchor, multiplier: 0.99).isActive = true
        self.detailMovieInformationView.movieImageView.isUserInteractionEnabled = true
        self.detailMovieInformationView.movieImageView.addGestureRecognizer(gestureRecognizer)
        
        self.tableView.addSubview(indicator)
        self.indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
    
//MARK:-Threads Work
    //dispatch group을 사용하여 전체적으로 데이터를 가져오는 작업이 완료된 이후에 알맞는 처리를 할 수 있도록 구현했습니다.
   private func UIAfterGetData() {
        self.indicator.startAnimating()
        self.getMovieDetailData()
        self.getCommentData()
        
        dispatchGroup.notify(queue: .main) {
            self.indicator.stopAnimating()
            self.movieId = self.movieDetailData.id
            self.tableView.reloadData()
        }
    }
    
   private func getMovieDetailData() {
        self.dispatchGroup.enter()
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieDetailData(movieId: movieId), errorOcurredBlock: {
            
            self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.urlFailure), animated: true, completion: nil)

        })
        NetworkManager.shared.fetch(with: request, decodeType: MovieDetailData.self) { [weak self] (result, response) in
            switch result {
            case .success(let data):
                  DispatchQueue.main.async {
                    //이미지 네트워킹이 오래걸리므로 다른 정보를 먼저 표시하여 사용자에게 빠른 반응을 보일 수 있도록 구현했습니다.
                    self?.movieDetailData = data
                    self?.detailMovieInformationView.movieDetailInformations = self?.movieDetailData ?? MovieDetailData()
                    self?.navigationItem.title = "\(self?.movieDetailData.title ?? "")"
                    self?.tableView.reloadData()
                    
                  }
                  
                guard let imageURL: URL = URL(string: data.image) else {
                        
                    return
                        
                }
                 
                /*
                   self가 weak로 참조하면서 옵셔널 타입이니깐, self를 아예 처음에 옵셔널 바인딩해서 사용해주는건 어떨까 싶습니다.
                */
                NetworkManager.shared.getImageWithCaching(url: imageURL) {[weak self] (image,error) in
                    
                    if error != nil {
                        DispatchQueue.main.async {
                            
                            self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.invalidData), animated: true, completion: nil)
                        }
                    }
                    guard let image = image else {
                           
                        return
                            
                    }
                     DispatchQueue.main.async {
                        self?.detailMovieInformationView.movieImageView.image = image
                        self?.dispatchGroup.leave()
                        }
                    }
                
            case.failure(_ ):
                 DispatchQueue.main.async {
                    self?.indicator.stopAnimating()
                    self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
                }
                self?.dispatchGroup.leave()
            }
        }
    }
    
   private func getCommentData(){
        self.dispatchGroup.enter()
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieDataIncludingComments(movieId: movieId), errorOcurredBlock: {
            
            self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.urlFailure), animated: true, completion: nil)

        })
        NetworkManager.shared.fetch(with: request, decodeType: APIResponseMovieCommentData.self) { [weak self] (result, response) in
            switch result {
            case .success(let data):
                self?.movieCommentData = data.comments
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                self?.dispatchGroup.leave()
            case.failure(_ ):
                 DispatchQueue.main.async {
                    self?.indicator.stopAnimating()
                self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
                }
                self?.dispatchGroup.leave()
            }
        }
    }

}




