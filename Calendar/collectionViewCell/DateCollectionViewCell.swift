//
//  DateCollectionViewCell.swift
//  SoftmonksCMSproject
//
//  Created by Shivakumar Harijan on 05/07/24.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateDigitLabel: UILabel!
    @IBOutlet weak var dateCellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configureCell(dateString: String, isCurrentDateCell: Bool, selectedDate: Date, indexPath: IndexPath) {
        dateDigitLabel.text = dateString
        let firstDayOfMonth = CalenderHelper().firstOfMonth(date: selectedDate)
        let indexOfFirstDate = CalenderHelper().weekDay(date: firstDayOfMonth) - 1
        let daysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        let lastDayIndex = indexOfFirstDate + daysInMonth
        
        if isCurrentDateCell {
            dateCellBackgroundView.backgroundColor = .white
        } else {
            dateCellBackgroundView.backgroundColor = .systemGray6
        }
        
        if let day = Int(dateString), day > 0 {
            if indexPath.item >= indexOfFirstDate && indexPath.item < lastDayIndex {
                dateDigitLabel.alpha = 1.0
                dateCellBackgroundView.alpha = 1.0
            } else {
                dateDigitLabel.alpha = 0.5
                dateCellBackgroundView.alpha = 0.4
            }
        }
        dateCellBackgroundView.layer.cornerRadius = 2.5
        dateCellBackgroundView.layer.borderWidth = 0.5
        dateCellBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
//        birthdayIcon.isHidden = (dayEventsList.birthday == 0)
//        holidayIcon.isHidden = (dayEventsList.holiday == 0)
//        leaveIcon.isHidden = (dayEventsList.leaves == 0)
//        urgentTaskIcon.isHidden = (dayEventsList.agenda == 0)
//        groupMeetingIcon.isHidden = (dayEventsList.meeting == 0)
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "DateCollectionViewCell", bundle: nil)
    }
}
