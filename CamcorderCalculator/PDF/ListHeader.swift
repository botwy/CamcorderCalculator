import UIKit

extension PDF {
    
    public struct ListHeader: ContentBlock {
        let font = UIFont.preferredFont(forTextStyle: .caption1)
        let text: String
        
        public init(text: String) {
            self.text = text
        }
        
        public var intristicHeight: CGFloat = 30
        
        public func draw(in bounds: CGRect, context: CGContext) {
            UIGraphicsPushContext(context)
            context.saveGState()
            
            let attributes = [NSAttributedString.Key.font: font]
            text.draw(at: CGPoint(x: 20, y: 13), withAttributes: attributes)
            
            context.restoreGState()
            UIGraphicsPopContext()
        }
    }
}

