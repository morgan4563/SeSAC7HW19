//
//  BoxOfficeViewController.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class BoxOfficeViewController: UIViewController {
    var movie = [MovieData]()

    let backgroundImage = UIImageView()
    let searchTextField = UITextField()
    let bottomLine = UIView()
    let baseDateLabel = UILabel()
    let searchButton = UIButton()
    let movieTableView = UITableView()
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierachy()
        configureLayout()
        configureView()

        callMovieData(date: getYesterDayString())
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }

    private func getYesterDayString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd"

        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        return df.string(from: yesterday)
    }

    @objc func searchButtonTapped() {
        callMovieData(date: searchTextField.text ?? "")
    }

    private func callMovieData(date: String) {
        loading(isLoading: true)
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=19c7b9971c926c02ce807c0a86370091&targetDt=\(date)"
        AF.request(url, method: .get)
            .responseDecodable(of: Movie.self) { response in

            switch response.result {
            case .success(let value):
                self.loading(isLoading: false)
                self.movie = value.boxOfficeResult.dailyBoxOfficeList
                self.movieTableView.reloadData()
                self.configureBaseDate(date: date)
            case .failure(let error):
                self.loading(isLoading: false)
                print("fail", error)
            }
        }
    }

    private func configureBaseDate(date: String) {
        baseDateLabel.text = "기준 날짜: \(date)"
    }

    private func loading(isLoading: Bool) {
        if isLoading {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
}

extension BoxOfficeViewController: ViewDesignProtocol {
    func configureHierachy() {
        view.addSubview(backgroundImage)
        view.addSubview(searchTextField)
        view.addSubview(bottomLine)
        view.addSubview(baseDateLabel)
        view.addSubview(searchButton)
        view.addSubview(movieTableView)
        view.addSubview(activityIndicator)
    }

    func configureLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(searchButton.snp.leading).offset(-16)
            make.height.equalTo(44)
        }
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.horizontalEdges.equalTo(searchTextField)
            make.height.equalTo(2)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        baseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(baseDateLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(60)
        }
    }

    func configureView() {
        backgroundImage.image = UIImage(named: "freepik_movieBackground")
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode = .scaleAspectFill

        searchTextField.textColor = .white

        bottomLine.backgroundColor = .white

        baseDateLabel.font = .systemFont(ofSize: 13, weight: .bold)
        baseDateLabel.textColor = .white

        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white

        movieTableView.backgroundColor = .clear
        movieTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)

        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchTextField.delegate = self

        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        activityIndicator.color = .white
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell

        cell.rank.text = movie[indexPath.row].rank
        cell.titleLabel.text = movie[indexPath.row].movieNm
        cell.dateLabel.text = movie[indexPath.row].openDt
        cell.backgroundColor = .clear

        return cell
    }
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        callMovieData(date: searchTextField.text ?? "")
        return true
    }
}
