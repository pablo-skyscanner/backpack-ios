/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI

struct WholeMonthCalendarContainer<MonthHeader: View, DayAccessoryView: View>: View {
    @Binding var selectionState: CalendarWholeMonthSelectionState
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let accessibilityProvider: WholeMonthDayAccessibilityProvider
    let monthScroll: MonthScroll?
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView

    private func handleSelection(_ date: Date) {
        selectionState.selectionAction(date)
    }

    @ViewBuilder
    private func cell(_ dayDate: Date) -> some View {
        if selectionState.range.contains(dayDate) {
            RangeSelectionCalendarDayCell(
                date: dayDate,
                selection: selectionState.range,
                calendar: calendar,
                highlightRangeEnds: false
            )
            .accessibilityLabel(Text(
                accessibilityProvider.accessibilityLabel(
                    for: dayDate,
                    selection: selectionState.range
                )
            ))
            .accessibility(addTraits: .isSelected)
        } else {
            DefaultCalendarDayCell(calendar: calendar, date: dayDate)
                .accessibilityLabel(Text(
                    accessibilityProvider.accessibilityLabel(for: dayDate)
                ))
        }
    }

    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        CalendarSelectableCell {
            cell(dayDate)
        } onSelection: {
            handleSelection(dayDate)
        }
        .accessibilityHint(Text(
            accessibilityProvider.accessibilityHint(
                for: dayDate,
                rangeSelectionState: selectionState
            )
        ))
        .accessibility(addTraits: .isButton)
    }

    private func initialSelection(_ initialDateSelection: Date, matchesDate date: Date) -> Bool {
        let matchingDayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(initialDateSelection, matchesComponents: matchingDayComponents)
    }

    var body: some View {
        CalendarContainer(
            calendar: calendar,
            validRange: validRange,
            monthScroll: monthScroll
        ) { month in
            monthHeader(month)
            CalendarMonthGrid(
                monthDate: month,
                calendar: calendar,
                validRange: validRange,
                dayCell: makeDayCell,
                emptyLeadingDayCell: { makeEmptyLeadingDayCell(for: month) },
                emptyTrailingDayCell: { makeEmptyTrailingDayCell(for: month) },
                dayAccessoryView: dayAccessoryView
            )
        }
    }

    /// - Parameters:
    ///   - firstDayOfMonth: The first day of the month we are showing
    @ViewBuilder
    private func makeEmptyLeadingDayCell(for firstDayOfMonth: Date) -> some View {
        DefaultEmptyCalendarDayCell()
    }

    /// - Parameters:
    ///   - firstDayOfMonth: The first day of the month we are showing
    @ViewBuilder
    private func makeEmptyTrailingDayCell(for firstDayOfMonth: Date) -> some View {
        EmptyView()
    }
}

struct WholeMonthCalendarContainer_Previews: PreviewProvider {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    static var previews: some View {
        let calendar = Calendar.current

        let start = calendar.date(from: .init(year: 2023, month: 10, day: 1))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!

        let startSelection = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let endSelection = calendar.date(from: .init(year: 2023, month: 11, day: 10))!

        WholeMonthCalendarContainer(
            selectionState: .constant(
                .init(
                    range: startSelection...endSelection,
                    returnMode: .range,
                    selectionAction: { _ in }
                )
            ),
            calendar: calendar,
            validRange: start...end,
            accessibilityProvider: WholeMonthDayAccessibilityProvider(
                accessibilityConfigurations: .init(
                    startSelectionHint: "",
                    endSelectionHint: "",
                    startSelectionState: "",
                    endSelectionState: "",
                    betweenSelectionState: "",
                    startAndEndSelectionState: "",
                    returnDatePrompt: ""
                ),
                dateFormatter: Self.formatter
            ),
            monthScroll: nil,
            monthHeader: { month in
                BPKText("\(Self.formatter.string(from: month))")
            },
            dayAccessoryView: { _ in
                BPKText("20", style: .caption)
            }
        )
    }
}
