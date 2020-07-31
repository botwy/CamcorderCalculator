import QuickLook

fileprivate class PreviewItem: NSObject, QLPreviewItem {

	private let url: URL
	private let title: String?

	public init(url: URL, title: String? = nil) {
		self.url = url
		self.title = title
	}

	public var previewItemTitle: String? {
		return title
	}

	public var previewItemURL: URL? {
		return url
	}
}

fileprivate class PreviewDataSource: QLPreviewControllerDataSource {
	public let item: PreviewItem

	public init(_ item: PreviewItem) {
		self.item = item
	}

    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
		return item
	}
}

extension QLPreviewController {
    public static func makePreviewController(for url: URL, with title: String? = nil) -> QLPreviewController {
        let result = PreviewController(url: url, title: title)
        
        return result
    }
}

public final class PreviewController: QLPreviewController {

	private let previewDataSource: PreviewDataSource

	public init(url: URL, title: String? = nil) {
		previewDataSource = PreviewDataSource(PreviewItem(url: url, title: title))
		super.init(nibName: nil, bundle: nil)
		dataSource = previewDataSource
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    public override  var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}
}
