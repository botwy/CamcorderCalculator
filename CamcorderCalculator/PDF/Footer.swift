import UIKit

extension PDF {
	public struct Footer: ContentBlock {
		public let intristicHeight: CGFloat = 50
		var currentPage: Int = 0
		var totalPages: Int = 0

		public init() {}

		private let rightMargin: CGFloat = 20
		private let topMargin: CGFloat = 10

		private let font = UIFont.preferredFont(forTextStyle: .caption1)

		private var countTitle: String {
			return "Страница \(currentPage) из \(totalPages)"
		}

		public func draw(in bounds: CGRect, context: CGContext) {
			UIGraphicsPushContext(context)
			context.saveGState()

			context.translateBy(x: 0, y: bounds.origin.y)

			let titleAttributes = [NSAttributedString.Key.font: font]

			let countSize = countTitle.size(withAttributes: titleAttributes)
			let countX = bounds.maxX - countSize.width - rightMargin

			countTitle.draw(at: CGPoint(x: countX, y: topMargin), withAttributes: titleAttributes)

			context.restoreGState()
			UIGraphicsPopContext()
		}
	}
}
