debug:
	- swift build --verbose

release:
	- swift build -Xswiftc -O --configuration release --static-swift-stdlib

test:
	- swift test

project:
	- swift package generate-xcodeproj

