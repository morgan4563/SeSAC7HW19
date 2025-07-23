//
//  LottoNumbersView.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit

class LottoNumbersView: UIView {
    let mainStack = UIStackView()
    let numberStack = UIStackView()
    let bonusStack = UIStackView()

    let plusLabel = UILabel()
    let bonusBall = LottoBallView()
    let bonusText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("스토리보드로 사용됨, 에러")
    }

    func configureRandomNumbers() {
        var numbers = (1...45).shuffled().prefix(7)
        let bonusNumber = numbers.removeLast()
        let lottoNumbers = numbers.sorted()

        lottoNumbers.forEach {
            let ball = LottoBallView()
            ball.configureNumber(number: $0)
            numberStack.addArrangedSubview(ball)
            ball.snp.makeConstraints { make in
                make.size.equalTo(40)
            }
        }
        bonusBall.configureNumber(number: bonusNumber)
    }
}

extension LottoNumbersView: ViewDesignProtocol {
    func configureHierachy() {
        self.addSubview(mainStack)

        mainStack.addArrangedSubview(numberStack)
        mainStack.addArrangedSubview(plusLabel)
        mainStack.addArrangedSubview(bonusStack)

        bonusStack.addArrangedSubview(bonusBall)
        bonusStack.addArrangedSubview(bonusText)
    }
    
    func configureLayout() {
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        plusLabel.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        bonusBall.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    func configureView() {
        mainStack.axis = .horizontal
        mainStack.spacing = 8
        mainStack.alignment = .top

        numberStack.axis = .horizontal
        numberStack.spacing = 4

        bonusStack.axis = .vertical
        bonusStack.spacing = 4
        bonusStack.alignment = .center

        plusLabel.text = "+"
        plusLabel.font = .systemFont(ofSize: 22, weight: .bold)
        plusLabel.textAlignment = .center

        bonusText.text = "보너스"
        bonusText.font = .systemFont(ofSize: 13, weight: .semibold)
        bonusText.textColor = .customGray
    }
}
