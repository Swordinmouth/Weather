//
//  WeekDayPicker.swift
//  Weather
//
//  Created by Valery on 08.08.2021.
//

import UIKit

enum Day: Int {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday

    static let allDays: [Day] = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]

    var title: String {
        switch self {
        case .monday: return "ПН"
        case .tuesday: return "ВТ"
        case .wednesday: return "СР"
        case .thursday: return "ЧТ"
        case .friday: return "ПТ"
        case .saturday: return "СБ"
        case .sunday: return "ВС"
        }
    }
}

@IBDesignable class WeekDayPicker: UIControl {
    var selectedDay: Day? = nil {
        didSet {
            updateSelectedDay()
            sendActions(for: .valueChanged)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!

    private func setupView() {
        for day in Day.allDays{
            let button = UIButton(type: .system)
            button.setTitle(day.title, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)

            button.addTarget(self, action: #selector(daySelected(button:)), for: .touchUpInside)
            buttons.append(button)
        }

        stackView = UIStackView(arrangedSubviews: buttons)
        addSubview(stackView)

        stackView.spacing = 8
        stackView.axis = .horizontal

        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }

    @objc func daySelected(button: UIButton) {
        guard let index = buttons.firstIndex(of: button) else { return }
        guard let day = Day(rawValue: index) else {return }
        selectedDay = day
    }

    private func updateSelectedDay() {
        for (index, button) in buttons.enumerated() {
            guard let day = Day(rawValue: index) else { continue }
            button.isSelected = day == selectedDay
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
}
