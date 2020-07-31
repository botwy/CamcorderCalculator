extension PDF {
	public struct Content {
		public var header: Header
		public var footer: Footer
		public var body: [ContentBlock]

		public init(header: Header, footer: Footer, body: [ContentBlock]) {
			self.header = header
			self.footer = footer
			self.body = body
		}
	}
}

extension PDF.Content {

	func pageCount(format: PDF.Page) -> Int {
		let contentArea = format.pointSize.height - header.intristicHeight - footer.intristicHeight
		let totalHeight = body.reduce(0) { $0 + $1.intristicHeight }
		let pageCount = (totalHeight / contentArea).rounded(.up)
		return Int(pageCount)
	}
}
