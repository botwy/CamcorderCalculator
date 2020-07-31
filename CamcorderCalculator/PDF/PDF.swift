import Foundation
import CoreGraphics
import UIKit

public struct PDF {
	public enum Page {
		case A4

		/// Points in Post Script notation
		public var pointSize: CGSize {
			switch self {
			case .A4: return CGSize(width: 595, height: 842)
			}
		}
	}

	public struct Meta {
		public var author: String // FamilyName MiddleName GivenName
		public var application: String
		public var title: String
		public var ownerPassword: String?

		public init(author: String, title: String, ownerPassword: String? = nil) {
			application = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
			self.author = author
			self.title = title
			self.ownerPassword = ownerPassword
		}

		var documentInfo: [AnyHashable: Any] {
			var info = [kCGPDFContextCreator: application,
						kCGPDFContextTitle: title,
						kCGPDFContextAuthor: author]
			if let password = ownerPassword {
				info [kCGPDFContextOwnerPassword] = password
			}
			return info
		}
	}

	let page: Page
	let meta: Meta
    let content: Content?

    public init(meta: Meta, page: Page = .A4, content: Content? = nil) {
		self.meta = meta
		self.page = page
        self.content = content
	}


	public func data(with content: Content? = nil) -> Data {
		
        let content: Content! = (content ?? self.content)
        
        guard content != nil else {
            assertionFailure("Missing content for PDF")
            
            let data = NSMutableData()
            UIGraphicsBeginPDFContextToData(data, pageRect, meta.documentInfo)
            UIGraphicsBeginPDFPage()
            UIGraphicsEndPDFContext()
            
            return data as Data
        }
        
        let data = NSMutableData()
		UIGraphicsBeginPDFContextToData(data, pageRect, meta.documentInfo)
		UIGraphicsBeginPDFPage()
		
		let context = UIGraphicsGetCurrentContext()!
		var totalHeight: CGFloat = 0

		var footer = content.footer
		let footerRect = self.footerRect(footer)
		let headerRect = self.headerRect(content.header)
		footer.currentPage = 1
		footer.totalPages = content.pageCount(format: page)
		context.saveGState()
		content.header.draw(in: headerRect, context: context)
		context.translateBy(x: 0, y: content.header.intristicHeight)
		totalHeight += content.header.intristicHeight

		for block in content.body {
			if totalHeight + block.intristicHeight + content.footer.intristicHeight > page.pointSize.height {
				context.restoreGState()
				footer.draw(in: footerRect, context: context)
				footer.currentPage += 1
				UIGraphicsBeginPDFPage()
				context.saveGState()
				totalHeight = 0
				context.translateBy(x: 0, y: 20)
			}

			let contentRect = CGRect(origin: .zero, size: CGSize(width: pageRect.width, height: block.intristicHeight))
			block.draw(in: contentRect, context: context)
			context.translateBy(x: 0, y: block.intristicHeight)
			totalHeight += block.intristicHeight
		}

		context.restoreGState()
		footer.draw(in: footerRect, context: context)

		UIGraphicsEndPDFContext()
		return data as Data
	}

	var pageRect: CGRect {
		return CGRect(origin: .zero, size: page.pointSize)
	}

	func footerRect(_ footer: ContentBlock) -> CGRect {
		let origin = CGPoint(x: 0, y: pageRect.maxY - footer.intristicHeight)
		let size = CGSize(width: pageRect.width, height: footer.intristicHeight)
		return CGRect(origin: origin, size: size)
	}

	func headerRect(_ header: ContentBlock) -> CGRect {
		let size = CGSize(width: pageRect.width, height: header.intristicHeight)
		return CGRect(origin: .zero, size: size)
	}

}
