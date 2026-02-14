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
            Text("Lịch sử").font(.largeTitle).bold().foregroundColor(Color(.primary))
            ScrollView{
                FilterButton(title: "Past Week").frame(maxWidth: .infinity, alignment: .trailing)
                Text("Hôm nay").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.gray)
                LazyVStack(spacing: 14){
                    ForEach(items){ item in
                        HistoryItem(record: item)
                    }
                }
            }
        }.padding(10)
    }
}

#Preview {
    HistoryView()
}
