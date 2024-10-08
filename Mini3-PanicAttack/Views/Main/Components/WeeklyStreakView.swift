//
//  WeeklyStreakView.swift
//  Mini3-PanicAttack
//
//  Created by Althaf Nafi Anwar on 21/08/24.
//

import SwiftUI

struct WeeklyStreakView: View {
    @State var viewModel: ExerciseTrackerViewModel
    @State var validStreaks: [DailyStreak] = []
    private var validMin: Int
    
    init(viewModel: ExerciseTrackerViewModel, validMin: Int = 3) {
        self.viewModel = viewModel
        self.validStreaks = []
        self.validMin = validMin
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(daysOfWeek(), id: \.self) { day in
                VStack {
                    Text(day.abbreviated)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .foregroundStyle(Calendar.current.isDateInToday(day.date) ? .primary600 : .neutral300)
                        .padding(.bottom, 4)
                    
                    Image(getStreakImageType(for: day.date))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                    
                }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color(.white).clipShape(RoundedRectangle(cornerRadius: 12)))
        .onAppear {
            self.validStreaks = viewModel.tracker?.getStreakData(min: validMin) ?? []
        }
    }
    
    // Function to get the days of the current week
    private func daysOfWeek() -> [DayInfo] {
        let calendar = Calendar.current
        let today = Date()
        
        // Find the last Sunday
        let startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today)!
        
        // Create an array of DayInfo for the week
        return (0..<7).map { index in
            let dayDate = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
            return DayInfo(date: dayDate)
        }
    }
    
    // Function to get the image based on streak type for a given date
    private func getStreakImageType(for date: Date) -> ImageResource {
        guard let _ = viewModel.tracker else { return .fireSkeleton }
        
        let calendar = Calendar.current
        let dayDate = calendar.startOfDay(for: date)
        
        if let streak = validStreaks.first(where: { calendar.startOfDay(for: $0.date) == dayDate }) {
            return streak.streakType.icon
        }
        
        return .fireSkeleton
    }
}
