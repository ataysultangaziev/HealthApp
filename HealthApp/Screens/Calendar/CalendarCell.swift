//
//  CalendarCell.swift
//  HealthApp
//
//  Created by Atay Sultangaziev on 13/8/22.
//

import UIKit
import SnapKit

class CalendarCell: UICollectionViewCell {

  static let reuseIdentifier = "\(CalendarCell.self)"

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 15)
    return label
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
    label.textAlignment = .center
    return label
  }()
  
  private var lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()
  
  private var containerView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = Layout.cornerRadius
    view.layer.borderWidth = Layout.borderWidth
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    containerView.addSubview(titleLabel)
    containerView.addSubview(subTitleLabel)
    containerView.addSubview(lineView)
    
    addSubview(containerView)
    
    titleLabel.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(Layout.calendarTitleHeight)
    }
    
    subTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(Layout.calendarTitleHeight)
    }
    
    lineView.snp.makeConstraints { make in
      make.top.equalTo(subTitleLabel.snp.bottom)
      make.leading.equalToSuperview().offset(Layout.lineViewOffset)
      make.trailing.equalToSuperview().offset(-Layout.lineViewOffset)
      make.height.equalTo(Layout.lineViewHeight)
    }
    
    containerView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup(title: String, subTitle: String, selected: Bool) {
    titleLabel.text = title
    subTitleLabel.text = subTitle
    titleLabel.textColor = selected ? .blue : .black
    subTitleLabel.textColor = selected ? .blue : .black
    containerView.layer.borderColor = selected ? UIColor.blue.cgColor : UIColor.white.cgColor
  }
}

//MARK: Layout
private extension Layout {
  static let calendarTitleHeight = 30 as CGFloat
  static let lineViewOffset = 5 as CGFloat
  static let lineViewHeight = 3 as CGFloat
  static let cornerRadius = 3 as CGFloat
  static let borderWidth = 1 as CGFloat
}
