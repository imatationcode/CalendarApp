//
//  ViewController.swift
//  Calendar
//
//  Created by Shivakumar Harijan on 11/07/24.
//

import UIKit

class CalendarVC: UIViewController {

    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var monthAndYearLabel: UILabel!
    @IBOutlet weak var weekDayStackView: UIStackView!
    var selectedDate = Date()
    var totalSquares = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calender"
        monthCollectionView.dataSource = self
        monthCollectionView.delegate = self
        
        monthCollectionView.register(DateCollectionViewCell.nib(), forCellWithReuseIdentifier: "DateCollectionViewCell")
        setUpMonthViewGrid()
//        monthDataAPIcall()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCellView()
    }
    
    func setCellView() {
        let flowLayoutForMonthGrid = monthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = (monthCollectionView.frame.size.width - 2) / 8
        let cellHeight = (monthCollectionView.frame.size.height - 2) / 7
        flowLayoutForMonthGrid.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayoutForMonthGrid.minimumInteritemSpacing = 2
        flowLayoutForMonthGrid.minimumLineSpacing = 2
        
        for case let view in weekDayStackView.arrangedSubviews {
            view.layer.cornerRadius = 2.5
            view.clipsToBounds = true
        }
    }
    
    @IBAction func tappedPreviouMonthButton(_ sender: Any) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setUpMonthViewGrid()
    }
    
    @IBAction func tappedNeextMonthButton(_ sender: Any) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setUpMonthViewGrid()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }

    func setUpMonthViewGrid() {
        totalSquares.removeAll()
        let calc = CalenderHelper()
        let daysInCurrentMonth = calc.daysInMonth(date: selectedDate)
        let firstDayOfMonth = calc.firstOfMonth(date: selectedDate)
        let startingSpaces = calc.weekDay(date: firstDayOfMonth) - 1
        
//        var count: Int = 1
        
        let previouMonth = calc.minusMonth(date: selectedDate)
        let daysInpreviousMonth = calc.daysInMonth(date: previouMonth)
        
        for i in stride(from: startingSpaces, to: 0, by: -1) {
            totalSquares.append(String(daysInpreviousMonth - i + 1))
        }
        
        for day in 1...daysInCurrentMonth {
            totalSquares.append(String(day))
        }
        
        var nextMonthDay = 1
        while (totalSquares.count % 7) != 0 {
            totalSquares.append(String(nextMonthDay))
            nextMonthDay += 1
        }
        
        monthAndYearLabel.text = calc.monthString(date: selectedDate) + " " + calc.yearString(date: selectedDate)
        monthCollectionView.reloadData()
    }
    
    func isCurrentDate(_ dateString: String) -> Bool {
        guard let day = Int(dateString), day != 0 else {
            return false
        }
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let selectedComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        
        return todayComponents.year == selectedComponents.year &&
               todayComponents.month == selectedComponents.month &&
               todayComponents.day == day
    }
}

extension CalendarVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let dateCell = monthCollectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
            let dateString = totalSquares[indexPath.item]
            dateCell.configureCell(dateString: dateString, isCurrentDateCell: isCurrentDate(dateString), selectedDate: selectedDate, indexPath: indexPath)
            return dateCell
    }
}

