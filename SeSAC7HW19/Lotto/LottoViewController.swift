//
//  LottoViewController.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    let lottoRoundSearchTextField = UITextField()
    let explainLabel = UILabel()
    let explainDateLabel = UILabel()
    let resultLabel = UILabel()
    let numberStackView = LottoNumbersView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierachy()
        configureLayout()
        configureView()
    }
}

extension LottoViewController: ViewDesignProtocol {
    func configureHierachy() {
        view.addSubview(lottoRoundSearchTextField)
        view.addSubview(explainLabel)
        view.addSubview(explainDateLabel)
        view.addSubview(resultLabel)
        view.addSubview(numberStackView)
    }

    func configureLayout() {
        lottoRoundSearchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoRoundSearchTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        explainDateLabel.snp.makeConstraints { make in
            make.top.equalTo(explainLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }

    func configureView() {
        view.backgroundColor = .white
        lottoRoundSearchTextField.borderStyle = .line
        lottoRoundSearchTextField.textAlignment = .center
        explainLabel.text = "당첨번호 안내"
        explainDateLabel.text = "2020-05-30 추첨"
        resultLabel.text = "200회 당첨결과"
        numberStackView.configureRandomNumbers()
    }
}
