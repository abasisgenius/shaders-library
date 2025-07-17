//
//  ContentView.swift
//  LearnMetalShaders
//
//  Created by Mohammed Abbas Mahin on 17/07/2025.
//

import SwiftUI

enum DotType: String, CaseIterable, Identifiable {
    case square, circle

    var id: String { self.rawValue }
}

struct ContentView: View {
    
    @State private var spacing: CGFloat = 6
    @State private var dotSize: CGFloat = 3
    @State private var dotType: DotType = .square
    
    var isCircle: Bool {
        return dotType == .circle
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                Capsule()
                //                .foregroundColor(.yellow)
                //                .font(.system(size: 128))
                
                    .fill(.red)
                    .frame(width: 300, height: 200)
                    .colorEffect(
                        Shader(
                            function: .init(library: .default, name: "dotMatrix"),
                            arguments: [
                                .float(spacing),
                                .float(dotSize),
                                .float(isCircle ? 1.0 : 0.0)
                            ])
                    )
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Picker("Choose Style", selection: $dotType) {
                    ForEach(DotType.allCases) { type in
                        Text(type.rawValue.capitalized)
                            .tag(type)   // <-- Important: tag the picker option!
                    }
                }
                .pickerStyle(.inline)
                
                Text("Spacing: \(spacing, specifier: "%.1f")")
                Slider(value: $spacing, in: 1...20)
                    .padding(.bottom)
                
                Text("Dot Size: \(dotSize, specifier: "%.1f")")
                Slider(value: $dotSize, in: 1...20)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    ContentView()
}
