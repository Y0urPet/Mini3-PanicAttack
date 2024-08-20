//
//  CheckInView.swift
//  Mini3-PanicAttack
//
//  Created by Timothy Andrian on 19/08/24.
//

import SwiftUI

struct CheckInView: View {
    @State private var sliderValue: Double = 0.0
    @State var selection = ItemCalendar(id: "1", name: "SUN",dateNumber: 1)
    var body: some View {
        ScrollView {
            VStack(spacing:28){
                VStack() {
                    Text("Hi there..")
                        .font(Font.custom("Rubik-SemiBold", size: 24))
                    Text("How was your day?")
                        .font(Font.custom("Rubik-Regular", size: 16))
                }
                VStack(spacing:16){
                    CustomSlider(
                        value: $sliderValue,
                        range: 0...100,
                        trackHeight: 28
                    )
                    .frame(width: 330)
                    HStack{
                        Text("Overwhelmed")
                            .font(.system(size: 14))
                        Spacer()
                        Text("Peaceful")
                            .font(.system(size: 14))
                    }
                }
                .padding()
                .background(.white)
                .clipShape(.rect(cornerRadius: 16))
                PickerCalendarView(selection: $selection)
                HStack {
                    Text("Today’s Exercise")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    Spacer()
                }
                VStack{
                    Rectangle()
                        .frame(height: 176)
                        .foregroundStyle(.blue)
                    HStack {
                        VStack(alignment: .leading){
                            Text("Deep Breathing")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Text("Find calm with each breath")
                                .font(.system(size: 14))
                        }
                        Spacer()
                    }
                    .padding()
                    Button {
                        
                    } label: {
                        Text("Start")
                            .foregroundStyle(.black)
                            .frame(width: 330)
                            .padding(.vertical, 8)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 53))
                    }
                    .padding(.bottom, 16)
                }
                .background(.white)
                .clipShape(.rect(cornerRadius: 12))
                
            }
            .padding()
        }
        .background(.neutral100)
    }
}

struct PickerCalendarView: View {
    @Binding var selection:ItemCalendar
    let listOfWeekDay = [
        ItemCalendar(id: "1", name: "SUN", dateNumber: 1),
        ItemCalendar(id: "2", name: "MON", dateNumber: 2),
        ItemCalendar(id: "3", name: "TUE", dateNumber: 3),
        ItemCalendar(id: "4", name: "WED", dateNumber: 4),
        ItemCalendar(id: "5", name: "THU", dateNumber: 5),
        ItemCalendar(id: "6", name: "FRI", dateNumber: 6),
        ItemCalendar(id: "7", name: "SAT", dateNumber: 7),
        ItemCalendar(id: "8", name: "SUN", dateNumber: 8),
        ItemCalendar(id: "9", name: "MON", dateNumber: 9),
        ItemCalendar(id: "10", name: "TUE", dateNumber: 10),
        ItemCalendar(id: "11", name: "WED", dateNumber: 11),
        ItemCalendar(id: "12", name: "THU", dateNumber: 12),
        ItemCalendar(id: "13", name: "FRI", dateNumber: 13),
        ItemCalendar(id: "14", name: "SAT", dateNumber: 14),
        ItemCalendar(id: "15", name: "SUN", dateNumber: 15),
        ItemCalendar(id: "16", name: "MON", dateNumber: 16),
        ItemCalendar(id: "17", name: "TUE", dateNumber: 17),
        ItemCalendar(id: "18", name: "WED", dateNumber: 18),
        ItemCalendar(id: "19", name: "THU", dateNumber: 19),
        ItemCalendar(id: "20", name: "FRI", dateNumber: 20),
        ItemCalendar(id: "21", name: "SAT", dateNumber: 21),
        ItemCalendar(id: "22", name: "SUN", dateNumber: 22),
        ItemCalendar(id: "23", name: "MON", dateNumber: 23),
        ItemCalendar(id: "24", name: "TUE", dateNumber: 24),
        ItemCalendar(id: "25", name: "Wed", dateNumber: 25),
        ItemCalendar(id: "26", name: "THU", dateNumber: 26),
        ItemCalendar(id: "27", name: "FRI", dateNumber: 27),
        ItemCalendar(id: "28", name: "SAT", dateNumber: 28),
        ItemCalendar(id: "29", name: "SUN", dateNumber: 29),
        ItemCalendar(id: "30", name: "MON", dateNumber: 20),
        ItemCalendar(id: "31", name: "TUE", dateNumber: 31),
        
    ]
    var body: some View {
        PickerCalendar(items: listOfWeekDay, selection: $selection) { item in
            VStack(spacing:20) {
                Text("\(item.name)")
                    .font(.system(size: 13))
                Text("\(item.dateNumber)")
                    .font(.system(size: 20))
                    .foregroundStyle(.yellow)
                    .brightness(-0.3)
                Circle()
                    .frame(width: 20)
                    .foregroundStyle(.yellow)
            }
            .frame(width: 40)
        }
        .clipShape(.rect(cornerRadius: 16))
    }
}

struct PickerCalendar<T: Identifiable & Equatable, C: RandomAccessCollection<T>, Content: View>: View  {
    let items: C
    @Binding var selection: T
    @ViewBuilder let itemBuilder: (T) -> Content
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(items) { source in
                    ZStack {
                        if selection == source {
                            Circle()
                                .frame(width: 44)
                                .offset(y:-2)
                                .foregroundStyle(.yellow.opacity(0.5))
                        }
                        Button {
                            selection = source
                        } label: {
                            itemBuilder(source)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .animation(.default, value: selection)
                    }
                }
            }
            .padding(4)
            .background(Color.white)
            .cornerRadius(16)
        }
        
    }
}

struct ItemCalendar: Identifiable, Equatable {
    let id: String
    let name: String
    let dateNumber: Int
}

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let trackHeight: CGFloat

    private let thumbDiameter: CGFloat = 54

    var body: some View {
        GeometryReader { geometry in
            let thumbRadius = thumbDiameter / 2
            let sliderWidth = geometry.size.width - thumbDiameter

            // Calculate the normalized value within the range
            let normalizedValue = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
            
            // Adjust xOffset to ensure thumb stays within bounds
            let xOffset = sliderWidth * normalizedValue
            
            ZStack(alignment: .leading) {
                // Track
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: trackHeight)
                    .cornerRadius(trackHeight / 2)

                // Thumb
                Circle()
                    .fill(Color.blue)
                    .frame(width: thumbDiameter, height: thumbDiameter)
                    .offset(x: xOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                // Calculate the new X position
                                let newX = gesture.location.x - thumbRadius
                                
                                // Clamp the newX to ensure the thumb stays within bounds
                                let clampedX = max(0, min(newX, sliderWidth))
                                
                                // Convert the clampedX to a new slider value
                                let newValue = Double(clampedX / sliderWidth) * (range.upperBound - range.lowerBound) + range.lowerBound
                                
                                // Update the binding value
                                self.value = newValue
                            }
                    )
            }
//            .padding(.horizontal, thumbRadius)
        }
        .frame(height: thumbDiameter) // Make sure the frame height fits the thumb
    }
}

#Preview {
    CheckInView()
}
