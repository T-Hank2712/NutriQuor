//
//  HistoryView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct HistoryView: View {
    let items: [History] = [
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(
                    year: 2025,
                    month: 1,
                    day: 24,
                    hour: 21,
                    minute: 04
                )
            )!
        ),
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(
                    year: 2025,
                    month: 1,
                    day: 24,
                    hour: 21,
                    minute: 04
                )
            )!
        ),
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(
                    year: 2025,
                    month: 1,
                    day: 24,
                    hour: 21,
                    minute: 04
                )
            )!
        ),
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(
                    year: 2025,
                    month: 1,
                    day: 24,
                    hour: 21,
                    minute: 04
                )
            )!
        ),
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(
                    year: 2025,
                    month: 1,
                    day: 24,
                    hour: 21,
                    minute: 04
                )
            )!
        ),
        History(
        image: Image("Example"),
        title: "Bánh quy ABC",
        warning: "Nhiều đường",
        score: "Xấu",
        time: Calendar.current.date(
            from: DateComponents(
                year: 2025,
                month: 1,
                day: 24,
                hour: 21,
                minute: 04
            )
        )!
        )]
    var body: some View {
        VStack {
            SearchBar(text: .constant(""))
            ScrollView{
                LazyVStack(spacing: 20){
                    ForEach(items){ item in
                        HistoryItem(record: item)
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
