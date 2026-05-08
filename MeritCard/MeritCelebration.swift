//
//  MeritCelebration.swift
//  MeritCard
//
//  Created by Jonathan Preston on 19/09/2025.
//

import SwiftUI

// Individual confetti particle
struct ConfettiPiece: Identifiable {
    let id = UUID()
    var x: Double
    var y: Double
    var rotation: Double
    var rotationSpeed: Double
    var fallSpeed: Double
    var color: Color
    var size: Double
    var shape: ConfettiShape
}

enum ConfettiShape: CaseIterable {
    case circle
    case square
    case triangle
    
    @ViewBuilder
    func view(size: Double) -> some View {
        switch self {
        case .circle:
            Circle()
                .frame(width: size, height: size)
        case .square:
            Rectangle()
                .frame(width: size, height: size)
        case .triangle:
            Triangle()
                .frame(width: size, height: size)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// Main confetti view
struct ConfettiView: View {
    @State private var confetti: [ConfettiPiece] = []
    @State private var animationTimer: Timer?
    
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink, .mint]
    let particleCount: Int
    let duration: TimeInterval
    
    init(particleCount: Int = 200, duration: TimeInterval = 5.0) {
        self.particleCount = particleCount
        self.duration = duration
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Transparent background
                Color.clear
                
                // Confetti particles
                ForEach(confetti) { piece in
                    piece.shape.view(size: piece.size)
                        .foregroundColor(piece.color)
                        .rotationEffect(.degrees(piece.rotation))
                        .position(x: piece.x, y: piece.y)
                }
            }
        }
        .allowsHitTesting(false) // Allows taps to pass through
        .onAppear {
            startConfetti(in: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        }
        .onDisappear {
            stopConfetti()
        }
    }
    
    private func startConfetti(in size: CGSize) {
        // Generate initial confetti pieces
        confetti = (0..<particleCount).map { _ in
            ConfettiPiece(
                x: Double.random(in: 0...size.width),
                y: -20, // Start above the screen
                rotation: Double.random(in: 0...360),
                rotationSpeed: Double.random(in: -5...5),
                fallSpeed: Double.random(in: 2...6),
                color: colors.randomElement() ?? .blue,
                size: Double.random(in: 6...12),
                shape: ConfettiShape.allCases.randomElement() ?? .circle
            )
        }
        
        // Start animation timer
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updateConfetti(screenSize: size)
        }
        
        // Stop after duration
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            stopConfetti()
        }
    }
    
    private func updateConfetti(screenSize: CGSize) {
        withAnimation(.linear(duration: 0.016)) {
            for i in confetti.indices {
                confetti[i].y += confetti[i].fallSpeed
                confetti[i].rotation += confetti[i].rotationSpeed
                
                // Remove pieces that have fallen off screen
                if confetti[i].y > screenSize.height + 50 {
                    confetti.remove(at: i)
                    break
                }
            }
        }
    }
    
    private func stopConfetti() {
        animationTimer?.invalidate()
        animationTimer = nil
        confetti.removeAll()
    }
}
