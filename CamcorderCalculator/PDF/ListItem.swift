import UIKit

extension PDF {
	public struct ListItem: ContentBlock {
        
        public var intristicHeight: CGFloat {
            return estimateFrame.height
        }
        
		let font = UIFont.preferredFont(forTextStyle: .caption1)
		let text: String
		let preface: String
        let indentLevel: CGFloat
        let page: PDF.Page
        
        public init(text: String, preface: String = "• ", indentLevel: Int = 1, page: PDF.Page = .A4) {
			self.text = text
			self.preface = preface
            self.indentLevel = CGFloat(indentLevel)
            self.page = page
		}
        
        private let leftIndent: CGFloat = 20
		private let rightIndent: CGFloat = 20
        private let topIndent: CGFloat = 3
		
        private var estimateFrame: CGRect {
			let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
			let attributes = [NSAttributedString.Key.font : font]
			
			let width = page.pointSize.width - leftIndent - rightIndent
            let preferredSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
			
			let frame = NSString(string: content).boundingRect(with: preferredSize, options: options, attributes: attributes, context: nil)
			
            return frame
        }
        
		private var content: String {
			return preface + text
		}

		public func draw(in bounds: CGRect, context: CGContext) {
			UIGraphicsPushContext(context)
			context.saveGState()

			let attributes = [NSAttributedString.Key.font: font]
            let drawingOptions: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
            let point = CGPoint(x: leftIndent * indentLevel, y: topIndent)
            let frame = CGRect(origin: point, size: estimateFrame.size)
            
            NSString(string: content).draw(with: frame, options: drawingOptions, attributes: attributes, context: nil)
            
			context.restoreGState()
			UIGraphicsPopContext()
		}
	}
}
