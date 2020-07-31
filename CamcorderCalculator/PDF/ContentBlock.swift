import CoreGraphics

public protocol ContentBlock {
	var intristicHeight: CGFloat { get }
	
	func draw(in bounds: CGRect, context: CGContext)
}

