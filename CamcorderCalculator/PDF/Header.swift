import CoreGraphics
import UIKit

extension PDF {
	public struct Header: ContentBlock {
		public var intristicHeight: CGFloat = 65
		let font = UIFont.preferredFont(forTextStyle: .headline)
		let header: NSString

		public init(header: String) {
			self.header = header as NSString
		}

		public func draw(in bounds: CGRect, context: CGContext) {
			UIGraphicsPushContext(context)
			context.saveGState()

			let attrubutes = [NSAttributedString.Key.font: font]
			header.draw(at: CGPoint(x:20, y: 30), withAttributes: attrubutes)

			context.restoreGState()
			UIGraphicsPopContext()
		}
	}
}

