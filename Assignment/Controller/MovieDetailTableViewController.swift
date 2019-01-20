//
//  MovieDetailViewController.swift
//  Assignment
//
//  Created by 고상범 on 2018. 12. 7..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    private let dispatchGroup = DispatchGroup()
    private let cellIdentifier = "commentCell"
    private let synopsisCellIdentifier = "synopsisCell"
    private let actorAndDirectorCellIdentifier = "actorAndDirectorCell"
    private var tableHeaderViewHeightAnchor = NSLayoutConstraint()
    private var movieCommentData = [MovieCommentData]()
    private var informationViewHeightConstraint = NSLayoutConstraint()
    private var synopsisViewHeightConstraint = NSLayoutConstraint()
    private var movieDetailData = MovieDetailData()
    public var movieId = ""
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY-MM-dd a hh:mm"
        return formatter
    }()
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(self.movieImageClicked))
        return recognizer
    }()
    
    private var informationHeadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private let detailMovieInformationView: DetailMovieInformationView = {
        guard let view = Bundle.main.loadNibNamed("DetailMovieInformationView", owner: self, options: nil)?.first as? DetailMovieInformationView else {
            
            return DetailMovieInformationView()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        UISetUp()
        UIAfterGetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if traitCollection.verticalSizeClass == .compact {
            tableHeaderViewHeightAnchor.isActive = false
            tableHeaderViewHeightAnchor = informationHeadView.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 0.8)
            tableHeaderViewHeightAnchor.isActive = true
        } else {
            tableHeaderViewHeightAnchor.isActive = false
            tableHeaderViewHeightAnchor = informationHeadView.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 0.45)
            tableHeaderViewHeightAnchor.isActive = true
        }
    }
    

    @objc func movieImageClicked() {
        let popUpVC: PopUpImageViewController = PopUpImageViewController()
            popUpVC.fullScreenImageView.image = detailMovieInformationView.movieImageView.image
        present(popUpVC, animated: false, completion: nil)
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
            return movieCommentData.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = SynopsisTableViewCell()
            cell.sizeToFit()
            cell.synopsisTextView.text = movieDetailData.synopsis
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = ActorAndDirectorTableViewCell()
            cell.directorLabel.text = movieDetailData.director
            cell.actorLabel.text = movieDetailData.actor
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentTableViewCell else {
                
                return UITableViewCell()
                
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
        tableView.tableHeaderView = informationHeadView
        tableView.tableHeaderView?.isUserInteractionEnabled = true
        informationHeadView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        informationHeadView.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        tableHeaderViewHeightAnchor = informationHeadView.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 0.35)
        tableHeaderViewHeightAnchor.isActive = true
        informationHeadView.addSubview(detailMovieInformationView)
        
        detailMovieInformationView.backgroundColor = .white
        detailMovieInformationView.widthAnchor.constraint(equalTo: informationHeadView.widthAnchor, multiplier: 1).isActive = true
        detailMovieInformationView.heightAnchor.constraint(equalTo: informationHeadView.heightAnchor, multiplier: 0.99).isActive = true
        detailMovieInformationView.movieImageView.isUserInteractionEnabled = true
        detailMovieInformationView.movieImageView.addGestureRecognizer(gestureRecognizer)
        
        tableView.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.tableHeaderView?.layoutIfNeeded()
        tableView.tableHeaderView = tableView.tableHeaderView
    }
    
//MARK:-Threads Work
    //dispatch group을 사용하여 전체적으로 데이터를 가져오는 작업이 완료된 이후에 알맞는 처리를 할 수 있도록 구현했습니다.
   private func UIAfterGetData() {
        indicator.startAnimating()
        getMovieDetailData()
        getCommentData()
        
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
        guard let self = self else { return }
        
        switch result {
        case let .success(data):
            DispatchQueue.main.async {
                //이미지 네트워킹이 오래걸리므로 다른 정보를 먼저 표시하여 사용자에게 빠른 반응을 보일 수 있도록 구현했습니다.
                self.movieDetailData = data
                self.detailMovieInformationView.movieDetailInformations = self.movieDetailData
                self.navigationItem.title = "\(self.movieDetailData.title)"
                self.tableView.reloadData()
                
            }
            guard let imageURL = URL(string: data.image) else { return }
            NetworkManager.shared.getImageWithCaching(url: imageURL) {[weak self] (image,error) in
                guard let self = self else { return }
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.invalidData), animated: true, completion: nil)
                    }
                }
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async {
                    self.detailMovieInformationView.movieImageView.image = image
                    self.dispatchGroup.leave()
                }
            }
            
        case .failure(_):
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
            }
            self.dispatchGroup.leave()
        }
    }
    }
    
    private func getCommentData(){
        self.dispatchGroup.enter()
        let request = NetworkManager.shared.requestBuilder.makeRequest(form: MovieAPI.movieDataIncludingComments(movieId: movieId), errorOcurredBlock: {
            
            self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.urlFailure), animated: true, completion: nil)
            
        })
        NetworkManager.shared.fetch(with: request, decodeType: APIResponseMovieCommentData.self) { [weak self] (result, response) in
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                self.movieCommentData = data.comments
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.dispatchGroup.leave()
            case .failure(_):
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: true, completion: nil)
                }
                self.dispatchGroup.leave()
            }
        }
    }
    
}




