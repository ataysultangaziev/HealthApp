//
//  ViewController.swift
//  HealthApp
//
//  Created by Atay Sultangaziev on 13/8/22.
//

import UIKit
import SnapKit

class CalendarViewController: BaseViewController {
  
  private var viewModel: CalendarViewModel
  
  var selectedDate = Date()
  var totalSquares = [Date]()
  
  private let numberOfDaysInWeek = 7
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionLayout = UICollectionViewFlowLayout()
    collectionLayout.minimumLineSpacing = Layout.collectionLayoutOffset
    collectionLayout.minimumInteritemSpacing = Layout.collectionLayoutOffset
    collectionLayout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionLayout)
    collectionView.backgroundColor = .clear
    collectionView.register(CalendarCell.self,
                            forCellWithReuseIdentifier: CalendarCell.reuseIdentifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.isPagingEnabled = true
    collectionView.showsHorizontalScrollIndicator = false
    
    return collectionView
  }()
  
  init(viewModel: CalendarViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setWeekView()
    
    view.backgroundColor = .white
    view.addSubview(titleLabel)
    view.addSubview(collectionView)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.horizontalEdges.equalTo(view.snp.horizontalEdges)
      make.height.equalTo(Layout.titleHeight)
    }
    
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(Layout.calendarHeight)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    for (index, date) in totalSquares.enumerated() {
      if date == selectedDate {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
      }
    }
  }
}

//MARK: UICollectionViewDelegate
extension CalendarViewController: UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.reuseIdentifier, for: indexPath) as! CalendarCell
    let date = totalSquares[indexPath.item]
    calendarCell.setup(
      title: viewModel.getWeekDay(for: date),
      subTitle: viewModel.getDayNumber(for: date),
      selected: date == selectedDate
    )
    return calendarCell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return totalSquares.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(
      width: (
        collectionView.frame.width - (
          Layout.collectionLayoutOffset * CGFloat(numberOfDaysInWeek)
        )
      ) / CGFloat(numberOfDaysInWeek),
      height: Layout.calendarHeight
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedDate = totalSquares[indexPath.item]
    
    titleLabel.text = viewModel.getMonth(for: selectedDate) +
    " " + viewModel.getYear(for: selectedDate) +
    " " + viewModel.getWeekDay(for: selectedDate) +
    " " + viewModel.getDayNumber(for: selectedDate)
    
    collectionView.reloadData()
  }
}

//MARK: Private
private extension CalendarViewController {
  func setWeekView() {
    let current = viewModel.getSunday(for: selectedDate)
    var previousSunday = viewModel.addDays(to: current, days: -numberOfDaysInWeek)
    let nextSunday = viewModel.addDays(to: current, days: numberOfDaysInWeek * 2)
    
    while (previousSunday < nextSunday) {
      totalSquares.append(previousSunday)
      previousSunday = viewModel.addDays(to: previousSunday, days: 1)
    }
    
    titleLabel.text = viewModel.getMonth(for: selectedDate) +
    " " + viewModel.getYear(for: selectedDate) +
    " " + viewModel.getWeekDay(for: selectedDate) +
    " " + viewModel.getDayNumber(for: selectedDate)
    
    collectionView.reloadData()
  }
}

//MARK: Layout
private extension Layout {
  static let collectionLayoutOffset = 5 as CGFloat
}
