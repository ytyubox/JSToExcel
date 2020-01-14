
install:
	swift build -c release
	install .build/release/JSToExcel JSToExcel
	

