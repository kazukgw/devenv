build:
	docker build -t devenv .

macos:
	git checkout macos
	docker build -t devenv .
