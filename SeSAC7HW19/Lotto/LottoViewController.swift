//
//  LottoViewController.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    let lottoRoundSearchTextField = UITextField()
    let explainLabel = UILabel()
    let explainDateLabel = UILabel()
    let resultLabel = UILabel()
    let numberStackView = LottoNumbersView()
    let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierachy()
        configureLayout()
        configureView()

        pickerView.delegate = self
        pickerView.dataSource = self
        lottoRoundSearchTextField.inputView = pickerView
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
            make.height.equalTo(40)
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
        lottoRoundSearchTextField.layer.borderColor = UIColor.systemGray6.cgColor
        lottoRoundSearchTextField.layer.borderWidth = 2

        explainLabel.text = "당첨번호 안내"

        explainDateLabel.text = "2020-05-30 추첨"

        resultLabel.text = "당첨결과"
        resultLabel.font = .systemFont(ofSize: 30, weight: .bold)
        callLottoData()
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1181
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1) 회차"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = row + 1
        lottoRoundSearchTextField.text = "\(selected)"
        callLottoData(round: selected)
    }

    func callLottoData(round: Int = 1181) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                let date = value.drwNoDate
                let round = value.drwNo
                let numbers = [value.drwtNo1, value.drwtNo2, value.drwtNo3, value.drwtNo4, value.drwtNo5, value.drwtNo6]
                let bonus = value.bnusNo

                let roundText = "\(round)회"
                let fullText = "\(roundText) 당첨결과"
                let attributeString = NSMutableAttributedString(string: fullText)
                let range = (fullText as NSString).range(of: roundText)
                attributeString.addAttribute(.foregroundColor, value: UIColor.customYellow, range: range)
                self?.resultLabel.attributedText = attributeString
                self?.numberStackView.configureNumbers(lottoNumbers: numbers, bonusNumber: bonus)
                self?.explainDateLabel.text = date

            case .failure(let error):
                print("fail", error)
            }
        }
    }
}
